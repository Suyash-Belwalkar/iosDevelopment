//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Suyash on 18/05/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){
                    image in image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                }placeholder:{
                    ProgressView()
                }
                .frame(width:390 ,height:233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Checkout"){
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Order placed", isPresented: $showingConfirmation){
            Button("OK"){}
        }message:{
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        //encoding of order object for sending it to server
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to enhance order")
            return
        }
        
        //setting url to which we will upload the data
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        //Acctual networking call using URLSession.shared.upload()
        do{
            let(data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //Now we decode the received response
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        }catch{
            print("Failed to place order \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
