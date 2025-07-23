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
        NavigationStack{
            VStack{
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.bottom)
                
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
                            .stroke(Color.black.opacity(1), lineWidth: 1)
                    )
                    .padding([.trailing, .leading], 40)
                    .padding(.bottom, 5)
                
                TextField("Enter Password", text: $password)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black.opacity(1), lineWidth: 1)
                    )
                    .padding([.trailing, .leading], 40)
                
                    Button("Login"){
                        //network call
                    }
                    .padding()
                    .frame(width: 100,height: 50)
                    .background(Color.black)
                    .foregroundStyle(.white)
                    .cornerRadius(20)
                    .padding(.top)
                
                ZStack{
                    
                    Rectangle()
                        .frame(width: 350, height: 90)
                        .foregroundStyle(.gray)
                        .opacity(0.5)
                        .cornerRadius(10)
                        .padding(.top,35)
                    HStack{
                        Text("Don't have an account?")
                        NavigationLink(destination: SignUpView()){
                            Text("Sign up")
                        }
                    }
                    .padding(.top,30)
                }
            }
        }
    }
}

#Preview {
    LoginPageView()
}
