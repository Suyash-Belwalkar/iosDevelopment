//
//  ContentView.swift
//  WordScambler
//
//  Created by Suyash on 15/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var showError = false
    
    @State private var score = 0
    @State private var totalScore = 0
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                ForEach(usedWords , id: \.self){word in
                    HStack{
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }
                Section{
                    Text("Score: \(totalScore)")
                        .bold()
                }
                
            }
            .navigationTitle(rootWord)
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .alert(errorTitle , isPresented: $showError){
                Button("OK"){ }
            }message: {
                Text(errorMsg)
            }
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    
                    Button("New Word"){
                        startGame()
                    }
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 20))
                    .shadow(radius: 10)
                    .font(.title2)
                }
            }
        }
    }
    func addWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count >= 3 else {
        wordError(title: "Too small", message: "Word should be more than or equal to 3 letters!!")
            newWord = ""
            return
        }
        
        guard isOriginal(word: answer) else{
            wordError(title: "Already Used", message: "Type in a new word!!!")
            newWord = ""
            return
        }
        
        guard isReal(word: answer) else{
            wordError(title: "Not a real word", message: "Such word does not exists")
            newWord = ""
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Not Possible", message: "This word is not possible")
            newWord = ""
            return
        }
        
        guard rootWordSame(word: answer)else{
            wordError(title: "Same Word", message: "Its the root word!!!")
            newWord = ""
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
            score = answer.count * 2
            totalScore += score
        }
        newWord = ""
    }
    
    func startGame(){
        usedWords.removeAll()
        totalScore = 0
        //find the file in bundle
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            //try converting it to a string
            if let startWord = try? String(contentsOf: startWordUrl){
                //convert to single string by removing new lines
                let allWords = startWord.components(separatedBy: "\n")
                //set root word as random word from allwords if unable to load nilcolesing silkworm
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        //if the start.txt is not found in the bundle app should crash due to fatal error
        fatalError("Cannot load the file start.txt into app!!!")
    }
    
    func isOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var temp = rootWord
        
        for letters in word {
            if let pos = temp.firstIndex(of: letters){
                temp.remove(at: pos)
            }else{
                return false
            }
          }
        return true
    }
    
    func isReal(word: String)-> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misSpelledRange.location == NSNotFound
    }
    
    func rootWordSame(word: String)-> Bool{
        if(word != rootWord){
            return true
        }
        else{
            return false
        }
    }
    
    func wordError(title: String , message: String){
        errorTitle = title
        errorMsg = message
        showError = true
    }
    
}

#Preview {
    ContentView()
}
