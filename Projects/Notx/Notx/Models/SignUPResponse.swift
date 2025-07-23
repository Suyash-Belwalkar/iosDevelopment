//
//  SignUPResponse.swift
//  Notx
//
//  Created by Suyash on 24/07/25.
//

import Foundation

struct SignUpResponse: Codable {
    let success: Bool
    let authtoken: String
}
