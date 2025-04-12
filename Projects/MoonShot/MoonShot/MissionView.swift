//
//  MissionView.swift
//  MoonShot
//
//  Created by Suyash on 08/04/25.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
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
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Mission Highlight")
                        .font(.largeTitle )
                        .bold()
                        .padding(.bottom , 5)
                    
                    Text(mission.description)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom , 7)
                    
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(crew, id: \.role){ crewMember in
                            NavigationLink{
                                AstronautsView(astronauts: crewMember.astronaut)
                            }label: {
                                VStack(alignment: .listRowSeparatorLeading){
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 330 , height: 260)
                                        .cornerRadius(10)
                                        .padding(.bottom , 5)

                                    
                                    VStack(alignment: .leading){
                                        Text(crewMember.astronaut.name)
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .padding(.leading , 5)
                                        
                                        Text(crewMember.role)
                                            .font(.headline)
                                            .foregroundStyle(.white.opacity(0.5))
                                            .padding(.leading , 5)
                                    }
                                }
                                .padding()
                            }
                            
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission:Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else{
                fatalError("Missing \(member.name)")
            }
            
        }
    }
}

#Preview {
    let missions:[Mission] = Bundle.main.decode("missions.json")
    let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
