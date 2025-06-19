//
//  UserView.swift
//  iExpense
//
//  Created by Suyash on 21/05/25.
//

import SwiftData
import SwiftUI

struct UserView: View {
    @Query(sort: \ExpenseItem.amount) var expenses: [ExpenseItem]
    
    var localCurrency : FloatingPointFormatStyle<Double>.Currency{
        .currency(code: Locale.current.currency?.identifier ?? "INR")//Challenge 1
    }
    
    @State private var showPersonalOnly = false
    
    var body: some View {
        List{
            if showPersonalOnly {
                Section("Personal") {
                    ForEach(expenses.filter { $0.type == "Personal" }) { item in
                        HStack{
                            Text(item.name)
                            
                            Spacer()
                            Text(item.amount , format: localCurrency)
                                .foregroundStyle(item.amount <= 10 ? .green : item.amount <= 100 ? .blue : .red)//Challenge 2
                        }
                    }
                }
            }else{
                // Business expenses section
                Section("Business") {
                    ForEach(expenses.filter { $0.type == "Business" }) { item in
                        HStack{
                            Text(item.name)
                            
                            Spacer()
                            Text(item.amount , format: localCurrency)
                                .foregroundStyle(item.amount <= 10 ? .green : item.amount <= 100 ? .blue : .red)
                        }
                    }
                }
            }
        }
    }
    
    init(type : String) {
        _expenses = Query(filter: #Predicate<ExpenseItem> { expense in
            expense.type ==  "Personal"
        }, sort: \ExpenseItem.name)
    }
}

#Preview {
    UserView(type: "Personal")
        .modelContainer(for: ExpenseItem.self)
}
