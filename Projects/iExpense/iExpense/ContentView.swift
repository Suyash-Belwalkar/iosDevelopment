//
//  ContentView.swift
//  iExpense
//
//  Created by Suyash on 25/07/24.
//

import SwiftUI

struct ExpenseItem{
    let name : String
    let type : String
    let amount : Double
}

@Observable
class Expenses{
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses.items , id: \.name){
                    item in
                    Text(item.name)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpenses")
            .toolbar{
                Button("Add Expense",systemImage: "plus"){
                    let expense = ExpenseItem(name: "suii", type: "test", amount: 20)
                    expenses.items.append(expense)
                }
            }
        }
        
    }
    
    func removeItem(at offset:IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
    
}

#Preview {
    ContentView()
}
