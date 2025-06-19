//
//  AddView.swift
//  iExpense
//
//  Created by Suyash on 06/04/25.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                
                Picker("Type" , selection: $type){
                    ForEach(types , id: \.self){
                     Text($0)
                    }
                }
                
                TextField("Amount" , value: $amount, format: .currency(code: "INR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add a new expense")
            .toolbar{
                Button("Save"){
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    modelContext.insert(expense)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView()
}
