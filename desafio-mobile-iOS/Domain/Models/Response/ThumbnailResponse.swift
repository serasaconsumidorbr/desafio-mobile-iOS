//
//  ThumbnailResponse.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

struct ThumbnailResponse {
    let path: String?
    let thumbnailExtension: String?
}

extension ThumbnailResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        path = try container.decodeIfPresent(String.self, forKey: .path)
        thumbnailExtension = try container.decodeIfPresent(String.self, forKey: .thumbnailExtension)
    }
}
