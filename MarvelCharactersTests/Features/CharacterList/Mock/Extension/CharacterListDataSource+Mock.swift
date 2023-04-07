//
//  CharacterListDataSource+Mock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Foundation
import MarvelCharacters

extension CharacterListDataSource {
    static var mockOnePage = CharacterListDataSource(
        copyright: "© 2023 MARVEL",
        items: [
            .carousell(
                characters: [
                    Character.mockOne,
                    Character.mockTwo
                ]
            ),
            .loading
        ],
        hasPartialCarousell: true,
        hasFullCarousell: false
    )
    
    static var mockTwoPages = CharacterListDataSource(
        copyright: "© 2023 MARVEL",
        items: [
            .carousell(
                characters: [
                    Character.mockOne,
                    Character.mockTwo,
                    Character.mockThree,
                    Character.mockFour
                ]
            ),
            .loading
        ],
        hasPartialCarousell: true,
        hasFullCarousell: false
    )
    
    static var mockThreePages = CharacterListDataSource(
        copyright: "© 2023 MARVEL",
        items: [
            .carousell(
                characters: [
                    Character.mockOne,
                    Character.mockTwo,
                    Character.mockThree,
                    Character.mockFour,
                    Character.mockFive
                ]
            ),
            .character(character: Character.mockSix),
            .loading
        ],
        hasPartialCarousell: true,
        hasFullCarousell: true
    )
    
    static var mockFourPages = CharacterListDataSource(
        copyright: "© 2023 MARVEL",
        items: [
            .carousell(
                characters: [
                    Character.mockOne,
                    Character.mockTwo,
                    Character.mockThree,
                    Character.mockFour,
                    Character.mockFive
                ]
            ),
            .character(character: Character.mockSix),
            .character(character: Character.mockSeven),
            .character(character: Character.mockEight)
        ],
        hasPartialCarousell: true,
        hasFullCarousell: true
    )
}
