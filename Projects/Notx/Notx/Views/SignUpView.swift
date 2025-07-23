//
//  SignUPView.swift
//  Notx
//
//  Created by Suyash on 23/07/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = AuthViewModel()
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
                    
                    Text("Signup")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(5)
                    
                    Text("Create account")
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
                    
                    TextField("Enter Password", text: $password)
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
                    
                    Button("SignUp"){
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        viewModel.signUP(email: emailID, password: password)
                    }
                    .padding()
                    .frame(width: 100,height: 50)
                    .background(Color.black)
                    .foregroundStyle(.white)
                    .cornerRadius(20)
                    .padding(.top)
                    
                    if let error = viewModel.errorMessage{
                        Text(error)
                            .foregroundStyle(.red)
                            .padding()
                    }
                    
                    ZStack{
                        
                        Rectangle()
                            .frame(width: 350, height: 90)
                            .foregroundStyle(.gray)
                            .opacity(0.5)
                            .cornerRadius(10)
                            .padding(.top,35)
                        HStack{
                            Text("Already have an account?")
                            NavigationLink(destination: LoginPageView()){
                                Text("Login")
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
        }
        .onChange(of: viewModel.isSignedUp){ isSignedUp in
            if isSignedUp{
                withAnimation{
                    authManager.isAuthenticated = true
                }
            }
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthManager())
}
