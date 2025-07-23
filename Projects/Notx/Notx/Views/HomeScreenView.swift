//
//  HomeScreenView.swift
//  Notx
//
//  Created by Suyash on 23/07/25.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Text("Note Taking App!")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Create, Update, and Delete notes with all Authentication features")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Spacer()
                HStack{
                    NavigationLink(destination: CreateNoteView()){
                        Text("Create Note")
                            .padding()
                            .frame(width: 150)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .foregroundStyle(.white)
                    }
                    .padding()
                    NavigationLink(destination: AllNotesView()){
                        Text("All Notes")
                            .padding()
                            .frame(width: 150)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
            }
            .navigationTitle("Notx")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        authManager.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
