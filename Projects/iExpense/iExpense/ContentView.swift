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
    var body: some View {
            NavigationStack{
                List{
                    ForEach(expenses.items){ item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: "INR"))
                        }
                    }
                    .onDelete(perform: removeItem)
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
    
    func removeItem(at offset:IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
