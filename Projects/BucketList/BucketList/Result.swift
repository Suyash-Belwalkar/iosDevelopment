//
//  Result.swift
//  BucketList
//
//  Created by Suyash on 17/06/25.
//

import Foundation

struct Result: Codable{
    let query : Query
}

struct Query: Codable{
    let pages: [Int: Page]
}

struct Page: Codable , Comparable{
    let pageid : Int
    let title : String
    let terms: [String: [String]]?
    
    var description : String{
        terms?["description"]?.first ?? "No further information"
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
