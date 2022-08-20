//
//  CharactersResponse.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 18/08/22.
//

import Foundation

struct CharactersResponse: Codable {
    let data: Results?
    let status: String?
}

struct Results: Codable {
    let results: [Character]
}

struct Character: Codable {
    let name: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}
