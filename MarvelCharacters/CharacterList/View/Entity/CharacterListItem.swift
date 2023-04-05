//
//  CharacterListItem.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 04/04/23.
//

import Foundation

public enum CharacterListItem: Equatable {
    case carousell(characters: [Character])
    case character(character: Character)
    case loading
}
