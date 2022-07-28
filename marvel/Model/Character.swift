//
//  Character.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 26/07/22.
//

import Foundation
import UIKit


struct CharacterListWrapper: Decodable {
    let data: CharacterList
}

struct CharacterList: Decodable {
    var offset: Int
    var total: Int
    var results: [Character]
}

struct Character: Decodable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: ImageUrl
}

struct ImageUrl: Decodable {
    var path: String
    var `extension`: String
}
