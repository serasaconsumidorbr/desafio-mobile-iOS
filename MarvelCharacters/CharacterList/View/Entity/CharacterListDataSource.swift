//
//  CharacterListDataSource.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 04/04/23.
//

import Foundation

public struct CharacterListDataSource: Equatable {
    var copyright: String?
    var items: [CharacterListItem]
    var hasPartialCarousell: Bool = false
    var hasFullCarousell: Bool = false
    
    mutating func updating(with characterList: CharacterList, shouldPaginate: Bool) {
        
        if !shouldPaginate {
            items = []
            hasPartialCarousell = false
            hasFullCarousell = false
        } else {
            items.removeLast(1)
        }
        
        copyright = characterList.copyright
        
        if hasFullCarousell {
            characterList.characters.forEach({ items.append(.character(character: $0)) })
        } else if hasPartialCarousell, items.count > 0, case let .carousell(characters) = items[0] {
            items.removeLast(1)
            let remainingItemsToFillCarousell = 5 - characters.count
            if characterList.characters.count >= remainingItemsToFillCarousell {
                let carousellItems = characters + Array(characterList.characters[0..<remainingItemsToFillCarousell])
                items.append(.carousell(characters: carousellItems))
                hasFullCarousell = true
                
                if characterList.characters.count > remainingItemsToFillCarousell {
                    characterList.characters[remainingItemsToFillCarousell..<characterList.characters.count].forEach({ items.append(.character(character: $0)) })
                }
            } else {
                let carousellItems = characters + characterList.characters
                items.append(.carousell(characters: carousellItems))
            }
        } else {
            if characterList.characters.count <= 5 {
                hasPartialCarousell = true
                hasFullCarousell = characterList.characters.count == 5
                items.append(.carousell(characters: characterList.characters))
            } else {
                hasPartialCarousell = true
                hasFullCarousell = true
                items.append(.carousell(characters: Array(characterList.characters[0..<5])))
                characterList.characters[5..<characterList.count].forEach({ items.append(.character(character: $0)) })
            }
        }
        if characterList.offset + characterList.count < characterList.total {
            items.append(.loading)
        }
    }
}

extension CharacterListDataSource {
    static var initialState: CharacterListDataSource {
        return CharacterListDataSource(items: [.loading])
    }
}
