//
//  CharacterModel.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 31/01/23.
//

import Foundation

struct CharacterWrapperModel: Codable {
    var status: String?
    var data: ChracterContainerModel?
}

struct ChracterContainerModel: Codable {
    var total: Int?
    var count: Int?
    var results: [CharacterModel]?
}

struct CharacterModel: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: ChracterThumbnailModel?
    var comics: ChracterComicsModel?
}

struct ChracterThumbnailModel: Codable {
    var path: String?
    var format: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
}

struct ChracterComicsModel: Codable {
    var available: Int?
    var items: [CharacterComicsItemsModel]?
}

struct CharacterComicsItemsModel: Codable {
    var resourceURI: String?
    var name: String?
}
