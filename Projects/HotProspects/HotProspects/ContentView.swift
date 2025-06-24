//
//  ContentView.swift
//  HotProspects
//
//  Created by Suyash on 19/06/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        TabView{
            ProspectsView(filter: .none)
                .tabItem{
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem{
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem{
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem{
                    Label("Me", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
