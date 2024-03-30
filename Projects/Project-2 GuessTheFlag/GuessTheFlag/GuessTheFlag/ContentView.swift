//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Suyash on 18/03/24.
//

import SwiftUI

struct ContentView: View {
   @State private var countries=["Germany","Italy","UK","US","Nigeria","Estonia","France","Ireland","Monaco","Ukraine","Spain"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var count = 0
    @State private var result = false
    @State private var resultStatement = ""
    var body: some View {
        ZStack{
            LinearGradient(colors: [.gray,.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("GUESS THE FLAG")
                    .font(.title.bold())
                
                VStack(spacing:15){
                    VStack {
                        Text("Choose the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.title.weight(.semibold))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                    }
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 20)
                        }
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,40)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Text("Your Score is:\(score)")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
            }
            .padding()
            
           
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Question left \(7-count)")
        }
        .alert(resultStatement, isPresented: $result){
            Button("Restart", action:askQuestion)
        }message: {
            Text("Press Restart to start again")
        }
    }
    func flagTapped(_ number:Int){
        if(number == correctAnswer){
            scoreTitle="Correct"
            score += 1
        }else{
            scoreTitle="Wrong!!! \nIt's the map of \(countries[number])"
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if(count == 7){
            count=0
            result=true
            resultStatement = "Your final score was:\(score)"
            score=0
        }else{
            count += 1
        }
    }
}

#Preview {
    ContentView()
}
