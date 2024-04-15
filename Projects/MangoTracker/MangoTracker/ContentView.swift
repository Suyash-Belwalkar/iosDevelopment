//
//  ContentView.swift
//  MangoTracker
//
//  Created by Suyash on 12/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    @State private var twoDz = 0
    @State private var twoFiveDz = 0
    @State private var threeDz = 0
    @State private var threeFiveDz = 0
    @State private var Total = 0
    @State private var price = 0
    @State private var mode = ""
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Name"){
                    TextField("Enter Name", text: $name)
                }
                
                Section("Order"){
                    Picker("2 dz",selection: $twoDz){
                        ForEach(0..<100){
                            Text("^[\($0) box](inflect:true)")
                        }
                    }
                    Picker("2.5 dz",selection: $twoFiveDz){
                        ForEach(0..<100){
                            Text("^[\($0) box](inflect:true)")
                        }
                    }
                    Picker("3 dz",selection: $threeDz){
                        ForEach(0..<100){
                            Text("^[\($0) box](inflect:true)")
                        }
                    }
                    Picker("3.5 dz",selection: $threeFiveDz){
                        ForEach(0..<100){
                            Text("^[\($0) box](inflect:true)")
                        }
                    }
                }
                Section("Total Order"){
                    Text("Total boxes : \(Total)")
                }
                Section("Total Price"){
                    Text("Total Price : \(price)/-")
                }
                Section("Payment Mode"){
                    TextField("Mode", text: $mode)
                }
                
            }
            .navigationTitle("Mango Order Tracker")
            .onChange(of: twoDz, calculateTotal)
            .onChange(of: twoFiveDz, calculateTotal)
            .onChange(of: threeDz, calculateTotal)
            .onChange(of: threeFiveDz, calculateTotal)
            .onChange(of: Total, calculatePrice)
            
        }
        
    }
    func calculateTotal(){
        Total = twoDz + twoFiveDz + threeDz + threeFiveDz
    }
    func calculatePrice(){
        price = Total * 1200
    }
}

#Preview {
    ContentView()
}
