//
//  Character.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

struct Character : Codable, Identifiable {
    
    let id = UUID()
    
    let name : String?
    
    let description : String?
    
    let thumbnail : Thumbnail?
    
}

extension Character {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
}
