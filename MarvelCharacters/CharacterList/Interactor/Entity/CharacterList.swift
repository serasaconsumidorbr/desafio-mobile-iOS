//
//  CharacterList.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

public struct CharacterList: Equatable, Decodable {
    var copyright: String
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var characters: [Character]
    
    public init(
        copyright: String,
        offset: Int,
        limit: Int,
        total: Int,
        count: Int,
        characters: [Character]
    ) {
        self.copyright = copyright
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.characters = characters
    }
    
    mutating func updating(with characterList: CharacterList) {
        copyright = characterList.copyright
        offset = characterList.offset
        limit = characterList.limit
        total = characterList.total
        count = characterList.count
        characters += characterList.characters
    }
    
    enum CodingKeys: String, CodingKey {
        case copyright
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        copyright = try values.decode(String.self, forKey: .copyright)
        
        let data = try values.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        offset = try data.decode(Int.self, forKey: .offset)
        limit = try data.decode(Int.self, forKey: .limit)
        total = try data.decode(Int.self, forKey: .total)
        count = try data.decode(Int.self, forKey: .count)
        characters = try data.decode([Character].self, forKey: .results)
    }
}
