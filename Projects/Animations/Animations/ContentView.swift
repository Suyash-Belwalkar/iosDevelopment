//
//  ContentView.swift
//  Animations
//
//  Created by Suyash on 05/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationEffect = 0.0
    var body: some View {
        VStack{
            
            Button("Suuiii"){
                withAnimation(.spring(duration: 1,bounce: 0.5)){
                    animationEffect += 360
                }
            }
            .padding(80)
            .background(.black)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationEffect),axis: (x:1, y:1, z:0)
            )
         
        }
        
    }
}

#Preview {
    ContentView()
}
