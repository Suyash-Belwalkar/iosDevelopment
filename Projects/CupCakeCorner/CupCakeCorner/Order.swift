//
//  Order.swift
//  CupCakeCorner
//
//  Created by Suyash on 18/05/25.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequest = "specialRequest"
        case _extraFrosting = "extraFrosting"
        case _extraSprinkles = "extraSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequest = false {
        didSet{
            if specialRequest == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var extraSprinkles = false
    
    var name = UserDefaults.standard.string(forKey: "name") ?? ""
    var streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
    var city = UserDefaults.standard.string(forKey: "city") ?? ""
    var zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal{
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if extraSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
        
    }
}
