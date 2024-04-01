//
//  ContentView.swift
//  Rock_Paper_Scissor
//
//  Created by Suyash on 30/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var options = ["✊","✋","✌️"]
    @State private var correctOption = ["✋","✌️","✊"]
    @State private var shouldWin = ["Win","Lose"]
    @State private var aim = Int.random(in: 0...1)
    @State private var chose = Int.random(in: 0...2)
    @State private var score = 0
    @State private var selected = ""
    @State private var alertMsg = ""
    @State private var showingScore = false
    @State private var count = 0
    
    
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
            }
            .frame(maxWidth:370)
            .padding(.vertical,50)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
        .alert(alertMsg, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Question left \(7-count)")
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
//        if(options[chose] == "✋" || options[chose] == "✊" && aim == 1){
////            alertMsg = "Correct"
//            score += 1
//           
//        }else if(options[chose] == "✌️" && aim == 0){
////            alertMsg = "Wrong"
//            score += 1
//        }else{
//            score -= 1
//        }

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
//        count += 1
    }
   
}

#Preview {
    ContentView()
}
