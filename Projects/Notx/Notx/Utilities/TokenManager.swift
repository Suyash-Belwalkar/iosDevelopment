//
//  TokenManager.swift
//  Notx
//
//  Created by Suyash on 24/07/25.
//

import Foundation

class TokenManager{
    static let shared = TokenManager()
    
    private let tokenKey = "jwtToken"
    
    func save(token: String){
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func clearToken(){
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
