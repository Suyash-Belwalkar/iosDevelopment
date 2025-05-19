//
//  AddressView.swift
//  CupCakeCorner
//
//  Created by Suyash on 18/05/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                    .onChange(of: order.name) { _ in saveDetails() }

                TextField("Address", text: $order.streetAddress)
                    .onChange(of: order.streetAddress) { _ in saveDetails() }

                TextField("City", text: $order.city)
                    .onChange(of: order.city) { _ in saveDetails() }

                TextField("Zip Code", text: $order.zip)
                    .onChange(of: order.zip) { _ in saveDetails() }
            }
            
            Section{
                NavigationLink("Checkout"){
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveDetails(){
        UserDefaults.standard.set(order.name, forKey: "name")
        UserDefaults.standard.set(order.streetAddress, forKey: "streetAddress")
        UserDefaults.standard.set(order.city, forKey: "city")
        UserDefaults.standard.set(order.zip, forKey: "zip")
    }
}

#Preview {
    AddressView(order: Order())
}
