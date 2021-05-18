//
//  CharacterDataModel.swift
//  Marvel
//
//  Created by andre mietti on 17/05/21.
//

import Foundation

class CharactersDataModel {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [CharacterResponseDataModel]?

    init(character: CharactersResponse) {
        self.offset = character.offset
        self.limit = character.limit
        self.total = character.total
        self.count = character.count
        self.results = self.getCharacterResponseDataModel(characters: character.results)
    }


    private func getCharacterResponseDataModel(characters: [CharacterResponse]?) -> [CharacterResponseDataModel] {
        var localCharacters = [CharacterResponseDataModel]()
        if !(characters?.isEmpty ?? .defaultValue) {
            for char in characters! {
                let c = CharacterResponseDataModel(chatacter: char)
                localCharacters.append(c)
            }
        }
        return localCharacters
    }
}
