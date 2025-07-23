//
//  AuthService.swift
//  Notx
//
//  Created by Suyash on 24/07/25.
//

import Foundation

final class AuthService{
    static let shared = AuthService()
    
    private init() {}
    
    func signUp(email: String, password: String) async throws -> String {
        guard let url = URL(string: "https://notx-prathamesh-b.vercel.app/api/auth/signup") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        request.httpBody = try JSONEncoder().encode(body)
       
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let result = try JSONDecoder().decode(SignUpResponse.self, from: data)
        
        guard result.success else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "SignUp Failed"])
        }
        
        return result.authtoken
        
    }
    
    func login(email: String, password: String) async throws -> String {
        guard let url = URL(string: "https://notx-prathamesh-b.vercel.app/api/auth/login") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["email": email, "password": password]
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let result = try JSONDecoder().decode(SignUpResponse.self, from: data)
        
        guard result.success else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Login Failed"])
        }
        
        return result.authtoken
    }
}
