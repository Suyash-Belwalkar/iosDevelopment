//
//  ContentView.swift
//  CupCakeCorner
//
//  Created by Suyash on 17/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select you type" , selection: $order.type){
                        ForEach(Order.types.indices , id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Quantity: \(order.quantity)" , value: $order.quantity , in: 3...20)
                }
                
                Section{
                    Toggle("Special Request?", isOn: $order.specialRequest)
                    
                    if order.specialRequest{
                        Toggle("Extra Frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Extra Sprinkles", isOn: $order.extraSprinkles)
                    }
                }
                
                Section{
                    NavigationLink("Address Details"){
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("CupCake Corner")
        }
    }
}

#Preview {
    ContentView()
}

