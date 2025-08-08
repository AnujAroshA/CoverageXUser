//
//  User.swift
//  CoverageXUser
//
//  Created by Arosha Piyadigama on 2025-08-07.
//

import Foundation

struct APIResponse: Codable {
    let results: [User]
}

struct User: Codable, Identifiable {
    
    var id: ID
    let name: Name
    let email: String
    let phone: String
    let picture: Picture
    
    /**
     Have to use ID property hashable inorder to confirming with Identifiable protocol
     */
    struct ID: Codable, Equatable, Hashable {
        let name: String
        let value: String?
    }
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
        
        var fullName: String {
            "\(title.capitalized) \(first.capitalized) \(last.capitalized)"
        }
    }
    
    struct Picture: Codable {
        let thumbnail: String
        let large: String
    }
}
