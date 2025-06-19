//
//  Location.swift
//  BucketList
//
//  Created by Suyash on 04/06/25.
//

import Foundation
import MapKit

struct Location :  Codable, Equatable, Identifiable {
    var id = UUID()
    var name : String
    var description: String
    var longitude : Double
    var latitude : Double
    
    var coordinates : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 lightbulbs.", longitude: -0.141, latitude: 51.501)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
