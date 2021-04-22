//
//  FetchComicsResponse.swift
//  Marvel
//
//  Created by João Pedro on 22/04/21.
//

import Foundation

// MARK: - FetchComicsResponse
struct FetchComicsResponse: Codable {
    let id: Int
    let title: String
    let issueNumber: Int
    let variantDescription, resultDescription: String
    let thumbnail: Thumbnail

    enum CodingKeys: String, CodingKey {
        case id
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case thumbnail
    }
}
