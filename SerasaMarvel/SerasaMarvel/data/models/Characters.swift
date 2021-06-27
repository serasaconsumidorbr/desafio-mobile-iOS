//
//  Characters.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

struct CharactersResult : Codable {
    let data : Characters?
}

extension CharactersResult {
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Characters : Codable {
    
    let offset : Int?
    
    let limit : Int?
    
    let total : Int?
    
    let count : Int?
    
    let results : [ Character ]?
    
}

extension Characters {
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}
