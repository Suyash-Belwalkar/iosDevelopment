//
//  Prospect.swift
//  HotProspects
//
//  Created by Suyash on 22/06/25.
//

import SwiftData

@Model
class Prospect{
    var name : String
    var emailAddress : String
    var isContacted : Bool
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
