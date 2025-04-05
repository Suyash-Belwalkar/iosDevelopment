//
//  ContentView.swift
//  Tables
//
//  Created by Suyash on 24/07/24.
//

import SwiftUI

struct NewView: View {
    var body: some View {
       Text("Detailed View")
    }
}

enum GameState: String, CaseIterable {
    case Easy, Medium, Hard
}

struct ContentView: View {
    @State private var isGameActive = false
    @State private var number = 2
    @State private var numOfQuestions = 1
    @State private var diff = [GameState.Easy, GameState.Medium, GameState.Hard]
    @State private var diffSelected = GameState.Easy
    @State private var questionNumber = "7"
    @State private var easyArray = ["2","3","4","5","6"]
    @State private var mediumArray = ["12","15","18","17","19"]
    @State private var hardArray = ["23","28","27","29","25"]
    @State private var count = 0
    @State private var answer = ""
    @State private var intQuestion = 0
    @State private var score = 0
    @State private var resultStatement = ""
    @State private var result = false
    
    var body: some View {
        NavigationStack{
            if(!isGameActive){
                ZStack{
                VStack{
                    Form{
                        Section{
                            Stepper("Table of \t\t\t\t\t\(number)", value: $number, in: 2...12)
                            
                            Picker("How many questions?", selection: $numOfQuestions){
                                ForEach(1..<6){
                                    Text("\($0)")
                                }
                            }
                            
                            Picker("Difficulty",selection: $diffSelected){
                                ForEach(Array(diff.enumerated()), id: \.offset) { index, element in
                                    Text("\(element)")
                                }
                            }
                            
                        }
                        NavigationLink(destination: NewView()) {
                            Text("Start Game")
                        }
                        Button("Start"){
                            startGame()
                            isGameActive = true
                        }
                        
                    }
                    
                }
            }
                    .navigationTitle("Settings")
                }
            if(isGameActive){
                ZStack{
                    LinearGradient(colors: [.cyan , .black], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack{
                        Text("Question")
                            .font(.largeTitle)
                            .bold()
                            .padding(20)
                        Text("\(number) x \(questionNumber)")
                        TextField("\t\t Answer", text: $answer)
                            .background(.thickMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                            .padding()
                        Button("Next"){
                            checkAnswer()
                            askQuestion()
                        }
                        .padding()
                        
                        Text("Score:\(score)")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.black)
                        Button("Settings"){
                            isGameActive = false
                        }
                        .padding()
                       
                    }
                    .frame(width:200)
                    .padding(40)
                    .background(.thinMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                   
                }
            }
        
        }
        .alert(resultStatement, isPresented: $result){
            Button("Settings", action:change123)
        }message: {
            Text("Your score was \(score)")
        }
    }
    
    func startGame(){
        score = 0
        count = 0
        answer = ""

        switch(GameState(rawValue: diffSelected.rawValue)) {
        case .Easy:
            easyArray.shuffle()
            questionNumber = easyArray.randomElement() ?? "7"
        case .Medium:
            mediumArray.shuffle()
            questionNumber = mediumArray.randomElement() ?? "17"
        case .Hard:
            hardArray.shuffle()
            questionNumber = hardArray.randomElement() ?? "23"
        default: break
        }
    }
    
    func askQuestion(){
        if(count < numOfQuestions){
            answer = ""
            switch GameState(rawValue: diffSelected.rawValue){
            case .Easy:
                easyArray.shuffle()
                questionNumber = easyArray.randomElement() ?? "7"
                count += 1
            case .Medium:
                mediumArray.shuffle()
                questionNumber = mediumArray.randomElement() ?? "17"
                count += 1
            case .Hard:
                hardArray.shuffle()
                questionNumber = hardArray.randomElement() ?? "23"
                count += 1
            default: break
            }
        }else{
            answer = ""
            count=0
            questionNumber = ""
            result = true
        }
    }
    
    func checkAnswer(){
        intQuestion = Int(questionNumber) ?? 0
        if(number * intQuestion == Int(answer)){
            score += 1
        }else{
            score = score
        }
    }
    
    func change123(){
        isGameActive = false
       

    }
    
}

#Preview {
    ContentView()
}
