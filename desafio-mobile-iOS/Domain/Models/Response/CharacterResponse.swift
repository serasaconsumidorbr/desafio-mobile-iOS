//
//  CharacterResponse.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

struct CharacterResponse {
    let id: Int?
    let name: String?
    let characterDescription: String?
    let thumbnail: ThumbnailResponse?
}

extension CharacterResponse: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case charachterDescription = "description"
        case thumbnail
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id).defaultValue
        name = try container.decodeIfPresent(String.self, forKey: .name).defaultValue
        characterDescription = try container.decodeIfPresent(String.self, forKey: .charachterDescription).defaultValue
        thumbnail = try container.decodeIfPresent(ThumbnailResponse.self, forKey: .thumbnail)
    }

}
