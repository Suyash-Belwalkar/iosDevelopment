//
//  AddOrder.swift
//  Mango25
//
//  Created by Suyash on 10/04/25.
//
import SwiftUI

struct AddOrder: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var boxs = 0
    @State private var amount = 0
    @State private var paid = false
    @State private var two = 0
    @State private var twoPointFive = 0
    @State private var three = 0
    @State private var showAlert = false

    var orders: Orders
    var orderToEdit: OrderItems?

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Box", selection: $boxs) {
                    ForEach(0...100, id: \.self) {
                        Text("\($0)")
                    }
                }
                .onChange(of: boxs) { newValue in
                    calculateAmount(for: newValue)
                }

                Picker("2s", selection: $two) {
                    ForEach(0...100, id: \.self) {
                        Text("\($0)")
                    }
                }

                Picker("2.5s", selection: $twoPointFive) {
                    ForEach(0...100, id: \.self) {
                        Text("\($0)")
                    }
                }

                Picker("3s", selection: $three) {
                    ForEach(0...100, id: \.self) {
                        Text("\($0)")
                    }
                }

                HStack {
                    Text("Amount")
                    Spacer()
                    Text(amount, format: .currency(code: "INR"))
                        .foregroundColor(.gray)
                }

                Toggle("Paid", isOn: $paid)
            }
            .navigationTitle(orderToEdit == nil ? "Add a new order" : "Edit Order")
            .toolbar {
                Button("Save") {
                    if (two + twoPointFive + three) != boxs {
                        showAlert = true
                        return
                    }

                    let newItem = OrderItems(
                        name: name,
                        boxs: boxs,
                        amount: Double(amount),
                        paid: paid,
                        two: two,
                        twoPointFive: twoPointFive,
                        three: three
                    )

                    if let existing = orderToEdit,
                       let index = orders.items.firstIndex(where: { $0.id == existing.id }) {
                        orders.items[index] = newItem
                    } else {
                        orders.items.append(newItem)
                    }

                    dismiss()
                }
            }
            .onAppear {
                if let order = orderToEdit {
                    name = order.name
                    boxs = order.boxs
                    amount = Int(order.amount)
                    paid = order.paid
                    two = order.two
                    twoPointFive = order.twoPointFive
                    three = order.three
                }
            }
            .alert("Mismatch!", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Sum of 2, 2.5, and 3 should equal total boxes.")
            }
        }
    }

    func calculateAmount(for boxs: Int) {
        amount = boxs * 1200
    }
}

