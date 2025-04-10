//
//  Batch.swift
//  Mango25
//
//  Created by Suyash on 11/04/25.
//


import SwiftUI

struct Batch: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var date: String
}

struct BatchSelectionView: View {
    @State private var batches: [Batch] = [
        Batch(name: "Batch 1", date: "12 Apr"),
        Batch(name: "Batch 2", date: "25 Apr")
    ]

    @State private var showAddBatchSheet = false
    @State private var newBatchName = ""
    @State private var selectedDate = Date()

    var body: some View {
        NavigationStack {
            List {
                ForEach(batches) { batch in
                    NavigationLink("\(batch.name) (\(batch.date))") {
                        ContentView(batch: batch)
                    }
                }
                .onDelete(perform: deleteBatch)
            }
            .navigationTitle("Mango2025🥭")
            .toolbar {
                Button("Add Batch", systemImage: "plus") {
                    showAddBatchSheet = true
                }
            }
            .sheet(isPresented: $showAddBatchSheet) {
                VStack(spacing: 20) {
                    Text("Add New Batch")
                        .font(.headline)
                    
                    TextField("Batch name", text: $newBatchName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                    
                    HStack {
                        Button("Cancel") {
                            newBatchName = ""
                            selectedDate = Date()
                            showAddBatchSheet = false
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
                        Button("Add") {
                            addBatch()
                            showAddBatchSheet = false
                        }
                        .disabled(newBatchName.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .presentationDetents([.medium])
            }
        }
    }

    func addBatch() {
        guard !newBatchName.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let formattedDate = formatDate(selectedDate)
        let newBatch = Batch(name: newBatchName, date: formattedDate)
        batches.append(newBatch)

        newBatchName = ""
        selectedDate = Date()
    }

    func deleteBatch(at offsets: IndexSet) {
        let batchesToDelete = offsets.map { batches[$0] }
        batches.remove(atOffsets: offsets)
        for batch in batchesToDelete {
            let batchKey = batch.name
            UserDefaults.standard.removeObject(forKey: batchKey)
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }
}
