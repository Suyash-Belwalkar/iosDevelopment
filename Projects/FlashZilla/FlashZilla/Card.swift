//
//  Card.swift
//  FlashZilla
//
//  Created by Suyash on 26/06/25.
//

import Foundation

struct Card: Codable{
    var question : String
    var answer : String
    
    static let example = Card(question: "Who is the GOAT of football", answer: "Cristiano Ronaldo")
}
