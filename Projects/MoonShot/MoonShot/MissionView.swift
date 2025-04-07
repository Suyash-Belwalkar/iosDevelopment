//
//  MissionView.swift
//  MoonShot
//
//  Created by Suyash on 08/04/25.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                                            width * 0.6
                    }
                    .padding([.top , .bottom] ,10)
                
                VStack(alignment:.leading){
                    Text("Mission Highlight")
                        .font(.title)
                        .padding(.bottom , 5)
                    
                    Text(mission.description)
                    
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions:[Mission] = Bundle.main.decode("missions.json")
    
    MissionView(mission: missions[0])
        .preferredColorScheme(.dark)
}
