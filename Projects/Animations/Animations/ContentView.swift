//
//  ContentView.swift
//  Animations
//
//  Created by Suyash on 05/07/24.
//

import SwiftUI

struct CornerRadiusModifier:ViewModifier{
    let amount : Double
    let anchor : UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount) , anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot : AnyTransition{
        .modifier(active: CornerRadiusModifier(amount: 90, anchor: .topLeading), identity:CornerRadiusModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var isShowingRed = false
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width:200 , height: 200)
            
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width:200 , height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}
