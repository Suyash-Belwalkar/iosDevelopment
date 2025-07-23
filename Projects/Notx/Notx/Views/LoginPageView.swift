//
//  LoginPage.swift
//  Notx
//
//  Created by Suyash on 23/07/25.
//

import SwiftUI

struct LoginPageView: View {
    
    @State private var emailID : String = ""
    @State private var password : String = ""
    var body: some View {
        VStack{
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding(.bottom, 40)
            
            Text("LOGIN")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(5)
            
            Text("Welcome Back !")
                .font(.headline)
                .padding(.bottom)
            
            TextField("Enter EmailID", text: $emailID)
                .padding(10)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
                )
                .padding([.trailing, .leading], 40)
            
            TextField("Enter Password", text: $password)
                .padding(10)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
                )
                .padding([.trailing, .leading], 40)
            HStack{
                Text("Don't have an account?")
                Button("Sign up"){
                   SignUpView()
                }
            }
        }
    }
}

#Preview {
    LoginPageView()
}
