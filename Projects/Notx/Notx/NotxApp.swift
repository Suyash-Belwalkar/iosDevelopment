//
//  NotxApp.swift
//  Notx
//
//  Created by Suyash on 23/07/25.
//

import SwiftUI

@main
struct NotxApp: App {
    @StateObject private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                HomeScreenView()
                    .environmentObject(authManager)
                    .transition(.opacity.combined(with: .scale))
            }else{
                SignUpView()
                    .environmentObject(authManager)
                    .transition(.opacity)
            }
        }
    }
}
