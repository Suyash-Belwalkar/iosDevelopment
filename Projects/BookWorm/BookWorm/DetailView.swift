//
//  DetailView.swift
//  BookWorm
//
//  Created by Suyash on 20/05/25.
//
import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @State private var showingAlert = false
    let book:Book
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.headline)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(Color.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5 , y: -5)
            }
            
            VStack{
                Text(book.author)
                    .font(.title)
                    .foregroundStyle(.secondary)
                
                Text(book.review)
                    .padding()
                
                HStack {
                    Text(book.date.formatted())
                        .padding()
                    Spacer()
                }
                
                StarRatingView(rating: .constant(book.rating))
                    .font(.title)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar{
            Button("Delete the Book", systemImage: "trash"){
                showingAlert = true
            }
        }
        .alert("Delete Book", isPresented: $showingAlert){
            Button("Delete", role:.destructive, action:deleteBook)
            Button("Cancel", role:.cancel){ }
        }message:{
            Text("Are you sure?")
        }
    }
    
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This was a great book; I really enjoyed it.", rating: 4, date: Date.now)

        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
