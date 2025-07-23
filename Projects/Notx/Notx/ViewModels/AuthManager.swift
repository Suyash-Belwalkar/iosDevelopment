//
//  AuthManager.swift
//  Notx
//
//  Created by Suyash on 24/07/25.
//

import Foundation
import SwiftUI

final class AuthManager: ObservableObject {
    @Published var isAuthenticated = false

    init() {
        if let token = TokenManager.shared.getToken(), !token.isEmpty {
            withAnimation{
                isAuthenticated = true
            }
        }
    }

    func logout() {
        TokenManager.shared.clearToken()
        isAuthenticated = false
    }
    
    
}
