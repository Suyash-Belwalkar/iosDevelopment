//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Suyash on 19/06/25.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit
import _MapKit_SwiftUI

extension ContentView{
    @Observable
    class ViewModel{
        private(set) var locations: [Location]
        var selectedPlace : Location?
        
        var isUnlocked = false
        var mapStyles = ["Standard" , "Hybrid"]
        var mapStyle = "Standard"
        var authErrorMessage : String? = "nil"
        var authError = false
        
        func currentMapStyle() -> MapStyle {
             switch mapStyle {
             case "Hybrid":
                 return .hybrid
             default:
                 return .standard
             }
         }

        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init(){
            do{
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            }catch{
                locations = []
            }
        }
        
        func save(){
            do{
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic , .completeFileProtection])
            }catch{
                print("Unable to save data")
            }
            
        }
        
        func addLocation(at point:CLLocationCoordinate2D){
            let newLocation = Location(name: "New Location", description: "", longitude: point.longitude, latitude: point.latitude)
            locations.append(newLocation)
            save()
        }
        
        func updateLocation(location: Location){
            guard let selectedPlace else {return}
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate(){
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate urself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success , authenticationError in
                    if success{
                        self.isUnlocked = true
                    }else{
                        self.authErrorMessage = authenticationError?.localizedDescription
                        self.authError = true
                    }
                }

            }else{
                authErrorMessage = error?.localizedDescription ?? "Biometrics unavailable."
                self.authError = true
            }
        }
    }
}
