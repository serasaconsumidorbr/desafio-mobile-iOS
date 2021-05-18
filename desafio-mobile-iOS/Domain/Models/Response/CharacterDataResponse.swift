//
//  CharacterDataResponse.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

struct CharacterDataResponse {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    var data: CharactersResponse?
}

extension CharacterDataResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case etag
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        code = try container.decodeIfPresent(Int.self, forKey: .code)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        attributionText = try container.decodeIfPresent(String.self, forKey: .attributionText)
        attributionHTML = try container.decodeIfPresent(String.self, forKey: .attributionHTML)
        etag = try container.decodeIfPresent(String.self, forKey: .etag)


        data = try container.decodeIfPresent(CharactersResponse.self, forKey: .data)
    }

}
