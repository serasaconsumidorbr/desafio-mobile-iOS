//
//  Character.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

public struct Character: Equatable, Decodable {
    let id: Int
    let name: String
    let description: String
    
    public init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
