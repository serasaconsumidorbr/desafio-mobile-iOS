//
//  Thumbnail.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

struct Thumbnail : Codable {
    
    let path : String?
    
    let ext : String?
    
}

extension Thumbnail {
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
