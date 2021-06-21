//
//  HeroesHomeModel.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 17/06/21.
//

import Foundation

// MARK: - Error Types
enum GenericError: Error{
    case cantUnwrap
}

enum MarvelAPIError: Error {
    case cantMakeRequest
    case cantTakeResponse
    case cantDecodableApiResponse
}

// MARK: - Codable Types
struct Root: Codable {
    var data: MarvelData
}

struct MarvelData: Codable {
    var total: Int
    var results: [MarvelCharacter]
}

struct MarvelCharacter: Codable {
    var name: String?
    var description: String?
    var thumbnail: MarvelCharacterImage?
}

struct MarvelCharacterImage: Codable {
    var path: String?
}
