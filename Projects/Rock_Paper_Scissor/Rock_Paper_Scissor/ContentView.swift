//
//  ContentView.swift
//  Rock_Paper_Scissor
//
//  Created by Suyash on 30/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var options = ["✊","✋","✌️"]
    @State private var shouldWin = ["Win","Lose"]
    @State private var aim = Int.random(in: 0...1)
    @State private var chose = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var count = 0
    @State private var showAlert = false
    @State private var resultStatement = ""
    @State private var question = 10
    var body: some View {
        ZStack{
            LinearGradient(colors: [.cyan, .black], startPoint: .top, endPoint: .bottom)
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
                        rock()
                        askQuestion()
                    }label: {
                        Text("✊")
                            .padding()
                            .frame(maxWidth:100)
                            .background(.black)
                            .clipShape(Circle())
                            .font(.system(size: 40))
                    }
                    
                    Button{
                        scissor()
                        askQuestion()
                    }label: {
                        Text("✌️")
                            .padding()
                            .frame(maxWidth:100)
                            .background(.black)
                            .clipShape(Circle())
                            .font(.system(size: 40))
                    }
                    
                    Button{
                        paper()
                        askQuestion()
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
                
                Text("Question remaining : \(question)")
                    .font(.title)
                    .bold()
            }
            .frame(maxWidth:370)
            .padding(.vertical,50)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
        .alert(resultStatement , isPresented: $showAlert){
            Button("Restart", action: askQuestion)
        }message: {
            Text("Press restart to play again!!!")
        }
    }
    func rock(){
        if(options[chose] == "✌️"){
            if(aim == 0){
                score += 1
            }else{
                score -= 1
            }
        }else if(options[chose] == "✋"){
            if(aim == 0){
                score -= 1
            }else{
                score += 1
            }
        }else if(options[chose] == "✊"){
            if(aim == 0){
                score -= 1
            }else{
                score += 1
            }
        }
    }
    func scissor(){
        if(options[chose] == "✌️"){
            if(aim == 0){
                score -= 1
            }else{
                score += 1
            }
        }else if(options[chose] == "✋"){
            if(aim == 0){
                score += 1
            }else{
                score -= 1
            }
        }else if(options[chose] == "✊"){
            if(aim == 0){
                score -= 1
            }else{
                score += 1
            }
        }
    }
    func paper(){
        if(options[chose] == "✌️"){
            if(aim == 0){
                score -= 1
            }else{
                score += 1
            }
        }else if(options[chose] == "✋"){
            if(aim == 0){
                score -= 1
            }else{
                score += 1
            }
        }else if(options[chose] == "✊"){
            if(aim == 0){
                score += 1
            }else{
                score -= 1
            }
        }
    }
    func askQuestion(){
        aim = Int.random(in: 0...1)
        chose = Int.random(in: 0...2)
        if(count == 9){
            
            showAlert = true
            count = 0
            resultStatement = "Your final score was : \(score)"
            score = 0
        }else{
            count += 1
            question = 10 - count
        }
    }
}

#Preview {
    ContentView()
}
