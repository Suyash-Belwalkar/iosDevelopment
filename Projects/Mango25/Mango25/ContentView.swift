//
//  ContentView.swift
//  Mango25
//
//  Created by Suyash on 10/04/25.
//

import SwiftUI

struct OrderItems: Codable, Identifiable, Equatable {
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

    init(batchId: UUID, batchName: String) {
        self.batchKey = "\(batchId.uuidString)-\(batchName)"
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
    @State private var searchText = ""

    init(batch: Batch) {
        self.batch = batch
        _orders = State(initialValue: Orders(batchId: batch.id, batchName: batch.name))
    }

    var localCurrency: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.currency?.identifier ?? "INR")
    }

    var totalBoxes: Int { filteredOrders.reduce(0) { $0 + $1.boxs } }
    var totalAmount: Double { filteredOrders.reduce(0) { $0 + $1.amount } }
    var totalPaid: Double { filteredOrders.filter { $0.paid }.reduce(0) { $0 + $1.amount } }
    var totalUnpaid: Double { filteredOrders.filter { !$0.paid }.reduce(0) { $0 + $1.amount } }
    var totalTwo: Int { filteredOrders.reduce(0) { $0 + $1.two } }
    var totalTwoPointFive: Int { filteredOrders.reduce(0) { $0 + $1.twoPointFive } }
    var totalThree: Int { filteredOrders.reduce(0) { $0 + $1.three } }


    var filteredOrders: [OrderItems] {
        if searchText.isEmpty {
            return orders.items
        } else {
            return orders.items.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .blue.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            StatView(title: "Total Boxes", value: "\(totalBoxes)", color: .blue)
                            Spacer()
                            StatView(title: "Total Amount", value: totalAmount.formatted(localCurrency), color: .blue, blurred: isAmountBlurred)
                                .onTapGesture { withAnimation(.easeInOut) { isAmountBlurred.toggle() } }
                        }
                        Divider()
                        HStack {
                            StatView(title: "Paid", value: totalPaid.formatted(localCurrency), color: .green)
                            Spacer()
                            StatView(title: "Unpaid", value: totalUnpaid.formatted(localCurrency), color: .red)
                        }
                        Divider()
                        HStack {
                            Text("2d: \(totalTwo)").foregroundColor(.gray)
                            Spacer()
                            Text("2.5d: \(totalTwoPointFive)").foregroundColor(.gray)
                            Spacer()
                            Text("3d: \(totalThree)").foregroundColor(.gray)
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(
                                            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                                        )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 3)
                    .padding()

                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search by name", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.primary)
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .gray.opacity(0.2), radius: 4)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    .animation(.easeInOut(duration: 0.2), value: searchText)

                    List {
                        ForEach(filteredOrders) { item in
                            NavigationLink(destination: AddOrder(orders: orders, orderToEdit: item)) {
                                OrderRowView(item: item, localCurrency: localCurrency)
                            }
                            .listRowBackground(Color.clear)
                            .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                        }
                        .onDelete(perform: removeItem)
                    }
                    .scrollContentBackground(.hidden)
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: filteredOrders)
                }
            }
            .navigationTitle(batch.name)
            .toolbar {
                NavigationLink(destination: AddOrder(orders: orders)) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white, .blue)
                        .shadow(radius: 2)
                }
            }
        }
    }

    struct StatView: View {
        let title: String
        let value: String
        let color: Color
        var blurred: Bool = false

        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.title3.bold())
                    .foregroundColor(color)
                    .blur(radius: blurred ? 3 : 0)
            }
        }
    }

    struct OrderRowView: View {
        let item: OrderItems
        let localCurrency: FloatingPointFormatStyle<Double>.Currency

        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("Boxes: \(item.boxs)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text(item.amount, format: localCurrency)
                    .font(.subheadline.bold())
                    .foregroundColor(item.paid ? .green : .blue)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .gray.opacity(0.2), radius: 4)
        }
    }

    func removeItem(at offset: IndexSet) {
        orders.items.remove(atOffsets: offset)
    }
}
