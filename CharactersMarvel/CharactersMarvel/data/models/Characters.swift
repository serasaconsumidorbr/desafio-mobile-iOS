//
//  Characters.swift
//  CharactersMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

struct CharactersResult : Codable, Identifiable, Hashable {
    let id = UUID()
    let data : Characters?
}

extension CharactersResult {
    enum CodingKeys: String, CodingKey {
        case id
        case data
    }
}

struct Characters : Codable, Identifiable, Hashable {
    
    let id = UUID()
    
    let offset : Int?
    
    let limit : Int?
    
    let total : Int?
    
    let count : Int?
    
    let results : [ Character ]?
    
}

extension Characters {
    enum CodingKeys: String, CodingKey {
        case id
        case offset
        case limit
        case total
        case count
        case results
    }
}
