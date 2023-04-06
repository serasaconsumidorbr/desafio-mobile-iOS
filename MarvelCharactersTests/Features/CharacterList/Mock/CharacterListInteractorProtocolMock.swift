//
//  CharacterListInteractorProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Foundation
import MarvelCharacters

class CharacterListInteractorProtocolMock: CharacterListInteractorProtocol {
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case loadCharacters(shouldPaginate: Bool)
    }
    
    func loadCharacters(shouldPaginate: Bool) {
        calledMethods.append(.loadCharacters(shouldPaginate: shouldPaginate))
    }
}
