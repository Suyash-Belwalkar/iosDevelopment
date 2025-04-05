//
//  ContentView.swift
//  Kick-Off_Squad
//
//  Created by Suyash on 22/09/24.
//

import SwiftUI

// Define Positions
enum Position: String, CaseIterable {
    case goalkeeper = "Goalkeeper"
    case defender = "Defender"
    case midfielder = "Midfielder"
    case forward = "Forward"
}

// Player struct with position and ratings
struct Player: Identifiable {
    let id = UUID()
    let name: String
    let position: Position
    var ratings: [Rating] = []
    
    var averageRating: Double {
        guard !ratings.isEmpty else { return 0.0 }
        let totalScore = ratings.reduce(0) { $0 + $1.totalScore }
        return Double(totalScore) / Double(ratings.count)
    }
}

// Rating struct to store peer feedback
struct Rating {
    let passerRating: Int
    let shooterRating: Int
    let defenderRating: Int
    let positioningRating: Int
    let teamworkRating: Int
    
    var totalScore: Int {
        return passerRating + shooterRating + defenderRating + positioningRating + teamworkRating
    }
}

// Main ContentView
struct ContentView: View {
    @State private var players: [Player] = []
    @State private var name: String = ""
    @State private var position: Position = .forward
    @State private var showingRatingView: Bool = false
    @State private var selectedPlayer: Player?
    @State private var showingSelectionSheet: Bool = false
    @State private var selectedPlayers: [Player] = []
    @State private var team1: [Player] = []
    @State private var team2: [Player] = []
    @State private var showingTeams: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Player Input Form
                Form {
                    Section(header: Text("Add Player")) {
                        TextField("Player Name", text: $name)
                        Picker("Position", selection: $position) {
                            ForEach(Position.allCases, id: \.self) { position in
                                Text(position.rawValue)
                            }
                        }
                        Button("Add Player") {
                            addPlayer()
                        }
                    }
                }
                
                // List of Players
                List(players) { player in
                    HStack {
                        Text(player.name)
                        Spacer()
                        Text("Avg Rating: \(String(format: "%.1f", player.averageRating))")
                    }
                    .onTapGesture {
                        selectedPlayer = player
                        showingRatingView = true
                    }
                }
                .sheet(isPresented: $showingRatingView) {
                    if let player = selectedPlayer {
                        RatingView(player: player) { rating in
                            updatePlayer(player: player, rating: rating)
                            showingRatingView = false
                        }
                    }
                }
                
                // Generate Teams Button
                Button(action: {
                    selectedPlayers = []
                    showingSelectionSheet = true
                }) {
                    Text("Select Players for Teams")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $showingSelectionSheet) {
                    SelectionSheet(players: players, selectedPlayers: $selectedPlayers, onGenerate: generateTeams, onDismiss: {
                        showingSelectionSheet = false // Dismiss the sheet
                    })
                }
                .alert(isPresented: $showingTeams) {
                    Alert(title: Text("Generated Teams"),
                          message: Text(displayTeams()),
                          dismissButton: .default(Text("OK")))
                }
            }
            .navigationTitle("Kick-Off Squad")
        }
    }
    
    // Function to add a player
    func addPlayer() {
        let newPlayer = Player(name: name, position: position)
        players.append(newPlayer)
        name = ""
    }
    
    // Function to update player ratings
    func updatePlayer(player: Player, rating: Rating) {
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            players[index].ratings.append(rating)
        }
    }
    
    // Function to generate balanced teams
    func generateTeams() {
        guard selectedPlayers.count == 12 else {
            print("Selected players count is not 12: \(selectedPlayers.count)")
            return
        }
        
        let shuffledPlayers = selectedPlayers.shuffled()
        team1 = Array(shuffledPlayers.prefix(6))
        team2 = Array(shuffledPlayers.suffix(6))
        
        // Show the teams alert
        DispatchQueue.main.async {
            showingTeams = true
        }
        print("Teams generated successfully.")
    }
    
    // Function to display teams as a string
    func displayTeams() -> String {
        let team1Names = team1.map { $0.name }.joined(separator: ", ")
        let team2Names = team2.map { $0.name }.joined(separator: ", ")
        return "Team 1: \(team1Names)\nTeam 2: \(team2Names)"
    }
}

// Selection Sheet for choosing players
struct SelectionSheet: View {
    var players: [Player]
    @Binding var selectedPlayers: [Player]
    var onGenerate: () -> Void
    var onDismiss: () -> Void // Dismiss handler
    
    var body: some View {
        NavigationView {
            List(players) { player in
                MultipleSelectionRow(player: player, isSelected: selectedPlayers.contains(where: { $0.id == player.id })) {
                    if selectedPlayers.contains(where: { $0.id == player.id }) {
                        selectedPlayers.removeAll { $0.id == player.id }
                    } else {
                        selectedPlayers.append(player)
                    }
                }
            }
            .navigationTitle("Select 12 Players")
            .navigationBarItems(trailing: Button("Generate Teams") {
                if selectedPlayers.count == 12 {
                    print("Generating teams with selected players: \(selectedPlayers.map { $0.name })")
                    onGenerate()
                    onDismiss() // Dismiss the sheet here
                } else {
                    print("Error: You must select exactly 12 players.")
                }
            })
        }
    }
}

// Row for multiple selection
struct MultipleSelectionRow: View {
    var player: Player
    var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        HStack {
            Text(player.name)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

// Rating View
struct RatingView: View {
    var player: Player
    var onSubmit: (Rating) -> Void
    
    @State private var passerRating: Int = 3
    @State private var shooterRating: Int = 3
    @State private var defenderRating: Int = 3
    @State private var positioningRating: Int = 3
    @State private var teamworkRating: Int = 3
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Rate \(player.name)")) {
                    RatingSlider(label: "Passing", rating: $passerRating)
                    RatingSlider(label: "Shooting", rating: $shooterRating)
                    RatingSlider(label: "Defending", rating: $defenderRating)
                    RatingSlider(label: "Positioning", rating: $positioningRating)
                    RatingSlider(label: "Teamwork", rating: $teamworkRating)
                }
                Button("Submit Rating") {
                    let rating = Rating(
                        passerRating: passerRating,
                        shooterRating: shooterRating,
                        defenderRating: defenderRating,
                        positioningRating: positioningRating,
                        teamworkRating: teamworkRating
                    )
                    onSubmit(rating)
                }
            }
            .navigationTitle("Rate Player")
            .navigationBarItems(trailing: Button("Done") {
                onSubmit(Rating(passerRating: 0, shooterRating: 0, defenderRating: 0, positioningRating: 0, teamworkRating: 0)) // Just to dismiss
            })
        }
    }
}

// Slider for rating input
struct RatingSlider: View {
    var label: String
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            Text(label)
            Slider(value: Binding(get: {
                Double(rating)
            }, set: { newValue in
                rating = Int(newValue.rounded())
            }), in: 1...5, step: 1)
            Text("\(rating)")
        }
    }
}

#Preview {
  ContentView()
}
