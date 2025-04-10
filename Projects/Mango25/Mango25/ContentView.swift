//
//  ContentView.swift
//  Mango25
//
//  Created by Suyash on 10/04/25.
//

import SwiftUI

struct OrderItems: Codable, Identifiable {
    var id = UUID()
    var name: String
    var boxs: Int
    var amount: Double
    var paid: Bool
    var two: Int
    var twoPointFive: Int
    var three: Int
}

@Observable
class Orders {
    var items = [OrderItems]() {
        didSet {
            saveItems()
        }
    }

    let batchKey: String

    init(batchKey: String) {
        self.batchKey = batchKey
        loadItems()
    }

    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: batchKey)
        }
    }

    func loadItems() {
        if let savedItems = UserDefaults.standard.data(forKey: batchKey) {
            if let decodedItem = try? JSONDecoder().decode([OrderItems].self, from: savedItems) {
                items = decodedItem
                return
            }
        }
        items = []
    }
}
struct ContentView: View {
    var batch: Batch
    @State private var orders: Orders
    @State private var showingAddExpense = false
    @State private var isAmountBlurred = true

    init(batch: Batch) {
        self.batch = batch
        _orders = State(initialValue: Orders(batchKey: batch.name)) // Use name as key
    }

    var localCurrency: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "INR")
    }

    var totalBoxes: Int {
        orders.items.reduce(0) { $0 + $1.boxs }
    }

    var totalAmount: Double {
        orders.items.reduce(0) { $0 + $1.amount }
    }

    var totalPaid: Double {
        orders.items.filter { $0.paid }.reduce(0) { $0 + $1.amount }
    }

    var totalUnpaid: Double {
        orders.items.filter { !$0.paid }.reduce(0) { $0 + $1.amount }
    }

    var totalTwo: Int {
        orders.items.reduce(0) { $0 + $1.two }
    }

    var totalTwoPointFive: Int {
        orders.items.reduce(0) { $0 + $1.twoPointFive }
    }

    var totalThree: Int {
        orders.items.reduce(0) { $0 + $1.three }
    }

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Boxes")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(totalBoxes)")
                                .font(.title2)
                                .bold()
                        }

                        Spacer()

                        VStack(alignment: .leading) {
                            Text("Total Amount")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(totalAmount, format: localCurrency)
                                .font(.title2)
                                .bold()
                                .blur(radius: isAmountBlurred ? 3 : 0)
                                .onTapGesture {
                                    withAnimation {
                                        isAmountBlurred.toggle()
                                    }
                                }
                        }
                    }

                    Divider().padding(.vertical, 4)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Paid")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Text(totalPaid, format: localCurrency)
                                .foregroundStyle(.green)
                        }

                        Spacer()

                        VStack(alignment: .leading) {
                            Text("Unpaid")
                                .font(.caption2)
                                .foregroundColor(.gray)
                            Text(totalUnpaid, format: localCurrency)
                                .foregroundStyle(.red)
                        }
                    }

                    Divider().padding(.vertical, 4)

                    HStack {
                        Text("2d: \(totalTwo)")
                        Spacer()
                        Text("2.5d: \(totalTwoPointFive)")
                        Spacer()
                        Text("3d: \(totalThree)")
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)

                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()

                List {
                    ForEach(orders.items) { item in
                        NavigationLink(destination: AddOrder(orders: orders, orderToEdit: item)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                        .font(.headline)

                                    HStack {
                                        Text("Boxes: \(item.boxs)")
                                        Spacer()
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                }

                                Text(item.amount, format: localCurrency)
                                    .foregroundStyle(item.paid ? .green : .blue)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: removeItem)
                }
            }
            .navigationTitle(batch.name)
            .toolbar {
                        NavigationLink(destination: AddOrder(orders: orders)) {
                            Label("Add Order", systemImage: "plus")
                        }
            }
        }
    }

    func removeItem(at offset: IndexSet) {
        orders.items.remove(atOffsets: offset)
    }
}
