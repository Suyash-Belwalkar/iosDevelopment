//
//  AddBookScreen.swift
//  BookWorm
//
//  Created by Suyash on 19/05/25.
//

import SwiftUI
import SwiftData

struct AddBookScreen: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review  = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Title", text:$title)
                    TextField("Author", text:$author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres , id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section("Write a Review"){
                    TextEditor(text: $review)
                    StarRatingView(rating: $rating)
                }
                
                Section{
                    Button("Save"){
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
                        
                        if newBook.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                            newBook.title = "N/A"
                        }
                        if newBook.author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                            newBook.author = "N/A"
                        }
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}


#Preview {
    AddBookScreen()
}
