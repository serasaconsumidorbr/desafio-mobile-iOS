//
//  CharacterDataWrapper.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

struct CharacterDataWrapper: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let etag: String?
    let data: CharacterDataContainer?
}

struct CharacterDataContainer: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
}
