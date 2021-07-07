//
//  Thumbnail.swift
//  CharactersMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

struct Thumbnail : Codable, Identifiable, Hashable {
    
    let id = UUID()
    
    let path : String?
    
    let ext : String?
    
}

extension Thumbnail {
    enum CodingKeys: String, CodingKey {
        case id
        case path
        case ext = "extension"
    }
}
