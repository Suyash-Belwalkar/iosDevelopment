//
//  LoginPage.swift
//  Notx
//
//  Created by Suyash on 23/07/25.
//

import SwiftUI

struct LoginPageView: View {
    
    @StateObject var viewModel = AuthViewModel()
    @EnvironmentObject var authManager: AuthManager
    
    @State private var emailID : String = ""
    @State private var password : String = ""
    var body: some View {
        NavigationStack{
            ZStack{
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
                        .submitLabel(.done)
                    
                    SecureField("Enter Password", text: $password)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black.opacity(1), lineWidth: 1)
                        )
                        .padding([.trailing, .leading], 40)
                        .submitLabel(.done)
                            .onSubmit {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    
                    Button("Login"){
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        viewModel.login(email: emailID, password: password)
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
                if viewModel.isLoading {
                                   Color.black.opacity(0.3)
                                       .ignoresSafeArea()
                                   ProgressView("Logging in...")
                                       .padding()
                                       .background(Color.white)
                                       .cornerRadius(12)
                                       .shadow(radius: 10)
                               }
            }
            .onChange(of: viewModel.isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    withAnimation{
                        authManager.isAuthenticated = true
                    }
                }
            }
            .alert("Login Failed", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button("OK") { viewModel.errorMessage = nil }
            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
        }
    }
}

#Preview {
    LoginPageView()
}
