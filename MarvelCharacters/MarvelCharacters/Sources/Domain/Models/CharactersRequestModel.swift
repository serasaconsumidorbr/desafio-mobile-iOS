//
//  CharactersRequestModel.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import Foundation

struct CharactersRequestModel: Codable {
    
    let name: String?
    let offset: Int?
    let limit: Int?
    
    init(name: String? = "",
         offset: Int?,
         limit: Int? = 15) {
        self.name = name
        self.offset = offset
        self.limit = limit
    }
    
    func asQueryItens() -> [URLQueryItem] {
        return [URLQueryItem(name: "limit", value: String(limit ?? 0)),
                URLQueryItem(name: "offset", value: String(offset ?? 0))]
    }
}
