//
//  CharactersModel+Fixture.swift
//  marvel-appTests
//
//  Created by Leonardo Bandeira on 02/02/23.
//

@testable import marvel_app

extension Character {
    static func fixture(
        name: String? = nil,
        description: String? = nil,
        thumbnail: CharacterImage? = nil
    ) -> Character {
        Character(name: name, description: description, thumbnail: thumbnail)
    }
}

