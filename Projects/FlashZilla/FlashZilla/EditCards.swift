//
//  EditCards.swift
//  FlashZilla
//
//  Created by Suyash on 28/06/25.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newQuestion = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newQuestion)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }

                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].question)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: loadData)
        }
    }

    func done() {
        dismiss()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }

    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }

    func addCard() {
        let trimmedQuestion = newQuestion.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedQuestion.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let card = Card(question: trimmedQuestion, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        newQuestion = ""
        newAnswer = ""
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

#Preview {
    EditCards()
}
