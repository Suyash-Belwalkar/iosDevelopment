//
//  ContentView.swift
//  iExpense
//
//  Created by Suyash on 25/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAddExpense = false
    @Environment(\.modelContext) var modelContext
    @Query var Expenses : [ExpenseItem]
    
    @State private var showingPersonalOnly = false
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    var localCurrency : FloatingPointFormatStyle<Double>.Currency{
        .currency(code: Locale.current.currency?.identifier ?? "INR")//Challenge 1
    }
    var body: some View {
            NavigationStack{
                UserView(type: showingPersonalOnly ? "Personal" : "Business")
                .navigationTitle("iExpenses")
                .toolbar{
                    Button("Add Expense",systemImage: "plus"){
                        showingAddExpense = true
                    }
                    .sheet(isPresented: $showingAddExpense){
                        AddView()
                    }
                    
                    Button(showingPersonalOnly ? "Show Business" : "Show Personal") {
                        showingPersonalOnly.toggle()
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder){
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            
                            Text("Sort by amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                    }
                }
            }
        }
    
    func removeItem(at offsets: IndexSet, forType type: String) {
//        let filteredItems = Expenses.enumerated().filter { $0.element.type == type }
//        for index in offsets {
//            let itemIndex = filteredItems[index].offset
//            modelContext.delete(itemIndex)
//        }
    }
    
}

#Preview {
    ContentView()
}
