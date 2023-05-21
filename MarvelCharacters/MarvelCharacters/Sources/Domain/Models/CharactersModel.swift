//
//  CharactersModel.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import Foundation


public struct CharacterDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterDataContainer?
    let etag: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case data
        case etag
    }
}

public struct CharacterDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Thumbnail?
    let comics: ComicList?
}

struct ComicList: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicSummary]
    let returned: Int
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

public struct ComicSummary: Codable {
    let resourceURI: String?
    let name: String
}
