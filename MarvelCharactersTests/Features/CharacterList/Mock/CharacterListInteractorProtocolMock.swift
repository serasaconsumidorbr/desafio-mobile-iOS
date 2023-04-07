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
        case loadCharactersPage
        case reloadCharacters
    }
    
    func loadCharactersPage() {
        calledMethods.append(.loadCharactersPage)
    }
    
    func reloadCharacters() {
        calledMethods.append(.reloadCharacters)
    }
}
