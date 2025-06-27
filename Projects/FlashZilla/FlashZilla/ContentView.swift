//
//  ContentView.swift
//  FlashZilla
//
//  Created by Suyash on 25/06/25.
//

import SwiftUI

extension View{
    func stacked(at position: Int , in total: Int) -> some View{
        let offset = Double(total - position)
        return self.offset(y:offset * 10)
    }
}

struct ContentView: View {
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var isShowingEditView = false
    
    var body: some View {
        ZStack{
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack{
                    ForEach(0..<cards.count, id: \.self){ index in
                        CardView(card: cards[index]){
                            withAnimation{
                                removeCard(at: index)
                            }
                        }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
                
            }
            
            VStack{
                HStack{
                    Spacer()
                    
                    Button{
                        isShowingEditView = true
                    }label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.title)
            .padding()
        }
        .onReceive(timer){ time in
            guard isActive else { return }
            
            if timeRemaining >= 0{
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $isShowingEditView, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func resetCards(){
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func removeCard(at index: Int){
        if cards.isEmpty{
            isActive = false
        }
        cards.remove(at: index)
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}

#Preview {
    ContentView()
}
