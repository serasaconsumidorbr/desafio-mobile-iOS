//
//  CharacterList+Mock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import MarvelCharacters

extension CharacterList {
    static var listMockPageOne = CharacterList(
        copyright: "© 2023 MARVEL",
        offset: 0,
        limit: 2,
        total: 1562,
        count: 2,
        characters: [
            Character.mockOne,
            Character.mockTwo
        ]
    )
    
    static var listMockPageTwo = CharacterList(
        copyright: "© 2023 MARVEL",
        offset: 2,
        limit: 2,
        total: 1562,
        count: 2,
        characters: [
            Character.mockThree,
            Character.mockFour
        ]
    )
    
    static var listMockPageOneAndTwo = CharacterList(
        copyright: "© 2023 MARVEL",
        offset: 2,
        limit: 2,
        total: 1562,
        count: 2,
        characters: [
            Character.mockOne,
            Character.mockTwo,
            Character.mockThree,
            Character.mockFour
        ]
    )
}
