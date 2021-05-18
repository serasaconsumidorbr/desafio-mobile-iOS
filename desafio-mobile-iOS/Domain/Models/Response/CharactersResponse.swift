//
//  CharactersResponse.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

struct CharactersResponse {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterResponse]?
}

extension CharactersResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        total = try container.decodeIfPresent(Int.self, forKey: .total)
        count = try container.decodeIfPresent(Int.self, forKey: .count)

        results = try container.decodeIfPresent([CharacterResponse].self, forKey: .results) ?? []
    }

}
