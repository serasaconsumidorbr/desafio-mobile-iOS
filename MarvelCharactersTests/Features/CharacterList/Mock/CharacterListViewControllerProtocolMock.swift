//
//  CharacterListViewControllerProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import MarvelCharacters

class CharacterListViewControllerProtocolMock: CharacterListViewControllerProtocol {
        
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case startLoading
        case stopLoading
        case updateDataSource(characterList: CharacterList, shouldPaginate: Bool)
    }
    
    func startLoading() {
        calledMethods.append(.startLoading)
    }
    
    func stopLoading() {
        calledMethods.append(.stopLoading)
    }
    
    func updateDataSource(_ characterList: MarvelCharacters.CharacterList, shouldPaginate: Bool) {
        calledMethods.append(.updateDataSource(characterList: characterList, shouldPaginate: shouldPaginate))
    }
}
