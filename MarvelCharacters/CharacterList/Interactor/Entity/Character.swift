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
    let imageURL: URL?
    
    public init(
        id: Int,
        name: String,
        description: String,
        imageURL: URL?
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    enum ImageKeys: String, CodingKey {
        case path
        case `extension`
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        
        let thumbnail = try values.nestedContainer(keyedBy: ImageKeys.self, forKey: .thumbnail)
        
        let path = try thumbnail.decode(String.self, forKey: .path)
        let ext = try thumbnail.decode(String.self, forKey: .extension)
        imageURL = URL(string: path.replacing("http", with: "https") + "." + ext)
    }
}
