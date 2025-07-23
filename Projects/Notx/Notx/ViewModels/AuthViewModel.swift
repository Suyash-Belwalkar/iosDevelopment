//
//  AuthViewModel.swift
//  Notx
//
//  Created by Suyash on 24/07/25.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isSignedUp = false
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    
    func signUP(email: String, password: String){
        isLoading = true
        Task{
            do{
                let token = try await AuthService.shared.signUp(email: email, password: password)
                TokenManager.shared.save(token: token)
                isSignedUp = true
            }catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func login(email: String, password: String) {
        isLoading = true
        Task {
            do {
                let token = try await AuthService.shared.login(email: email, password: password)
                TokenManager.shared.save(token: token)
                isLoggedIn = true
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}
