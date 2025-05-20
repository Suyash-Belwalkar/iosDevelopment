//
//  ContentView.swift
//  BookWorm
//
//  Created by Suyash on 19/05/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort:[
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]

    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? .red : .primary)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBook)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookScreen()
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet){
        for offset in offsets{
            let book = books[offset]
                modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
