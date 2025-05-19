//
//  Batch.swift
//  Mango25
//
//  Created by Suyash on 11/04/25.
//


import SwiftUI

struct Batch: Identifiable, Hashable, Codable { // Add Codable for JSON encoding/decoding
    var id = UUID()
    var name: String
    var date: String
}

struct BatchSelectionView: View {
    @State private var batches: [Batch] = []
    @State private var showAddBatchSheet = false
    @State private var newBatchName = ""
    @State private var selectedDate = Date()

    private let batchesKey = "SavedBatches"

    init() {
        loadBatches()
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                List {
                    ForEach(batches) { batch in
                        NavigationLink(destination: ContentView(batch: batch)) {
                            BatchCardView(batch: batch)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                    }
                    .onDelete(perform: deleteBatch)
                }
                .scrollContentBackground(.hidden)
                .animation(.easeInOut(duration: 0.3), value: batches)
            }
            .navigationTitle("Mango2025🥭")
            .toolbar {
                Button(action: { showAddBatchSheet = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white, .blue)
                        .shadow(radius: 2)
                }
                .scaleEffect(showAddBatchSheet ? 0.9 : 1.0)
                .animation(.spring(), value: showAddBatchSheet)
            }
            .sheet(isPresented: $showAddBatchSheet) {
                AddBatchSheet(newBatchName: $newBatchName, selectedDate: $selectedDate, onAdd: addBatch)
                    .presentationDetents([.medium])
                    .transition(.move(edge: .bottom))
            }
            .onChange(of: batches) { _ in saveBatches() }
        }
    }

    struct BatchCardView: View {
        let batch: Batch

        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(batch.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(batch.date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        }
    }

    struct AddBatchSheet: View {
        @Binding var newBatchName: String
        @Binding var selectedDate: Date
        let onAdd: () -> Void

        @Environment(\.dismiss) var dismiss

        var body: some View {
            VStack(spacing: 20) {
                Text("Add New Batch")
                    .font(.title2.bold())
                    .foregroundColor(.blue)

                TextField("Batch name", text: $newBatchName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding(.horizontal)
                    .accentColor(.blue)

                HStack {
                    Button("Cancel") {
                        newBatchName = ""
                        selectedDate = Date()
                        dismiss()
                    }
                    .foregroundColor(.red)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.red.opacity(0.1))
                    .clipShape(Capsule())

                    Spacer()

                    Button("Add") {
                        onAdd()
                        dismiss()
                    }
                    .disabled(newBatchName.trimmingCharacters(in: .whitespaces).isEmpty)
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(newBatchName.isEmpty ? Color.gray : Color.blue)
                    .clipShape(Capsule())
                    .scaleEffect(newBatchName.isEmpty ? 1.0 : 1.05)
                    .animation(.easeInOut(duration: 0.2), value: newBatchName)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 10)
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
            let batchKey = "\(batch.id.uuidString)-\(batch.name)"
            UserDefaults.standard.removeObject(forKey: batchKey)
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }

    func saveBatches() {
        if let encoded = try? JSONEncoder().encode(batches) {
            UserDefaults.standard.set(encoded, forKey: batchesKey)
        }
    }

    mutating func loadBatches() {
        if let savedData = UserDefaults.standard.data(forKey: batchesKey),
           let decodedBatches = try? JSONDecoder().decode([Batch].self, from: savedData) {
            _batches = State(initialValue: decodedBatches)
        } else {
            _batches = State(initialValue: [
                Batch(name: "Batch 1", date: "12 Apr"),
                Batch(name: "Batch 2", date: "25 Apr")
            ])
        }
    }
}

#Preview {
    BatchSelectionView()
}
