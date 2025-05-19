//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Suyash on 19/05/25.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
