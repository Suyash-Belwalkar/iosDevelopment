//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Suyash on 19/06/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
