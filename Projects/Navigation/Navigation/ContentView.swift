//
//  ContentView.swift
//  Navigation
//
//  Created by Suyash on 21/04/25.
//

import SwiftUI


class PathStore: ObservableObject{
    @Published var path = NavigationPath()
}

struct Player: Hashable{
    var name: String
    var position: String
}

struct MessiView: View {
    @EnvironmentObject var pathStore: PathStore
    var body: some View {
       
        VStack{
            Button("Ankara messi"){
                pathStore.path.append("123")
                
            }
        }
        
    }
}

struct ContentView: View {
    @StateObject private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path){
            VStack{
                Button("Go to Ronaldo"){
                    pathStore.path.append(Player(name: "Suyash", position: "LW"))
                }
                
                Button("Go to Messi"){
                    pathStore.path.append("Messi")
                }
            }
            .navigationDestination(for: String.self){ player in
                if player == "Messi"{
                    MessiView()
                }else {
                    Text("hiii")
                }
                
            }
            .navigationDestination(for: Player.self){ player in
                Text("Player name : \(player.name)")
                Text("Player position : \(player.position)")
            }
        }
        .environmentObject(pathStore)
    }
}

#Preview {
    ContentView()
}
