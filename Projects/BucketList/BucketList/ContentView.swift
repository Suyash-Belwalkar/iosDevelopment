//
//  ContentView.swift
//  BucketList
//
//  Created by Suyash on 28/05/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )
    
        @State private var viewModel = ViewModel()

    
    var body: some View {
        if viewModel.isUnlocked{
        MapReader{ proxy in
            ZStack{
            Map(initialPosition: startPosition){
                ForEach(viewModel.locations){ location in
                    Annotation(location.name, coordinate: location.coordinates){
                        Image(systemName:"star")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .background(.red)
                            .contentShape(Rectangle())
                            .clipShape(.circle)
                            .simultaneousGesture(LongPressGesture().onEnded { _ in
                                print("Long pressed \(location.name)")
                                viewModel.selectedPlace = location
                            })
                    }
                }
            }
            .mapStyle(viewModel.currentMapStyle())
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local){
                    viewModel.addLocation(at: coordinate)
                }
            }
            .sheet(item: $viewModel.selectedPlace){ place in
                EditView(location: place){
                    viewModel.updateLocation(location: $0)
                }
            }
                VStack {
                    HStack {
                        Spacer()
                        Picker("Style", selection: $viewModel.mapStyle) {
                            ForEach(viewModel.mapStyles, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    }
                    Spacer()
                }
               
        }
    }
        }else{
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
            
                .alert("Authentication Failed",
                       isPresented: $viewModel.authError
                        ) {
                            Button("OK") { viewModel.authErrorMessage = nil }
                        } message: {
                            Text(viewModel.authErrorMessage ?? "")
                        }
        }
    }
}

#Preview {
    ContentView()
}
