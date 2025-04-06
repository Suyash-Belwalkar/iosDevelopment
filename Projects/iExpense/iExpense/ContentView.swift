//
//  ContentView.swift
//  iExpense
//
//  Created by Suyash on 25/07/24.
//

import SwiftUI

struct ExpenseItem: Identifiable , Codable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
}



@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded , forKey: "Item")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Item"){
            if let decodedItem = try? JSONDecoder().decode([ExpenseItem].self ,from: savedItems){
                items = decodedItem
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var localCurrency : FloatingPointFormatStyle<Double>.Currency{
        .currency(code: Locale.current.currency?.identifier ?? "INR")//Challenge 1
    }
    var body: some View {
            NavigationStack{
                List{
                        // Personal expenses section
                        Section("Personal") {
                            ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                                HStack{
                                    Text(item.name)
                                    
                                    Spacer()
                                    Text(item.amount , format: localCurrency)
                                        .foregroundStyle(item.amount <= 10 ? .green : item.amount <= 100 ? .blue : .red)//Challenge 2
                                }
                            }
                            .onDelete { indexSet in
                                removeItem(at: indexSet , forType: "Personal")
                            }
                        }

                        // Business expenses section
                        Section("Business") {
                            ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                                HStack{
                                    Text(item.name)
                                    
                                    Spacer()
                                    Text(item.amount , format: localCurrency)
                                        .foregroundStyle(item.amount <= 10 ? .green : item.amount <= 100 ? .blue : .red)
                                }
                            }
                            .onDelete { indexSet in
                                removeItem(at: indexSet , forType: "Business")
                            }
                        }
                }
                .navigationTitle("iExpenses")
                .toolbar{
                    Button("Add Expense",systemImage: "plus"){
                        showingAddExpense = true
                    }
                    .sheet(isPresented: $showingAddExpense){
                        AddView(expenses: expenses)
                    }
                }
            }
        }
    
    func removeItem(at offsets: IndexSet, forType type: String) {
        let filteredItems = expenses.items.enumerated().filter { $0.element.type == type }
        for index in offsets {
            let itemIndex = filteredItems[index].offset
            expenses.items.remove(at: itemIndex)
        }
    }
}

#Preview {
    ContentView()
}
