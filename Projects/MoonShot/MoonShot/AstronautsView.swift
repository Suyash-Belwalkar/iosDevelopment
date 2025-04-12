//
//  AstronautsView.swift
//  MoonShot
//
//  Created by Suyash on 13/04/25.
//

import SwiftUI

struct AstronautsView: View {
    let astronauts : Astronaut
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronauts.id)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .padding()
                
                Text(astronauts.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronauts.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    AstronautsView(astronauts: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
}
