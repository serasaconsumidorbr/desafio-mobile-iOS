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
    
    enum Methods {
        case startLoading
        case stopLoading
    }
    
    func startLoading() {
        calledMethods.append(.startLoading)
    }
    
    func stopLoading() {
        calledMethods.append(.stopLoading)
    }
}
