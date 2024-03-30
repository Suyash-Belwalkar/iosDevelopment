//
//  ContentView.swift
//  Rock_Paper_Scissor
//
//  Created by Suyash on 30/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var options = ["✊","✋","✌️"]
    @State private var shouldWin = ["Win" , "Lose"]
    @State private var aim = Int.random(in: 0...1)
    @State private var chose = Int.random(in: 0...2)
    @State private var score = 0
    @State private var selected = ""
    
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.cyan , .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                Text("SCORE: \(score)")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                    .bold()
                
                Text("System Chooses:")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.gray)
                
                Text("\(options[chose])")
                    .font(.system(size: 80))
                
                Text("AIM:  \(shouldWin[aim])")
                    .font(.title2)
                    .bold()
                
                HStack{
                    
                    Button{
                        
                    }label: {
                        Text("✊")
                            .padding()
                            .frame(maxWidth:100)
                            .background(.black)
                            .clipShape(Circle())
                            .font(.system(size: 40))
                    }
                    
                    Button{
                        
                    }label: {
                        Text("✌️")
                            .padding()
                            .frame(maxWidth:100)
                            .background(.black)
                            .clipShape(Circle())
                            .font(.system(size: 40))
                    }
                    
                    Button{
                        
                    }label: {
                        Text("✋")
                            .padding()
                            .frame(maxWidth:100)
                            .background(.black)
                            .clipShape(Circle())
                            .font(.system(size: 40))
                    }
                }
                .frame(height: 150)
                .background(.clear)
                .padding(.vertical,40)
                .clipShape(.rect(cornerRadius: 20))
            }
            .frame(maxWidth:370)
            .padding(.vertical,50)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
      
    }
    
}

#Preview {
    ContentView()
}
