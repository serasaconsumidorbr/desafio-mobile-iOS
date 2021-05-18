//
//  CharacterRequest.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

struct CharacterRequest {
    let timestamp: String
    let apikey: String
    let hash: String
}

extension CharacterRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case timestamp = "ts"
        case apikey = "apikey"
        case hash = "hash"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(apikey, forKey: .apikey)
        try container.encode(hash, forKey: .hash)
    }
}
