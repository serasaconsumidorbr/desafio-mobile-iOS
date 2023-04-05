//
//  CharacterListPresenterProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import MarvelCharacters

class CharacterListPresenterProtocolMock: CharacterListPresenterProtocol {
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case startLoading
        case stopLoading
        case didLoadSuccessfully(characterList: CharacterList, shouldPaginate: Bool)
        case didFailLoading(message: String)
        
        static func == (lhs: CharacterListPresenterProtocolMock.Methods, rhs: CharacterListPresenterProtocolMock.Methods) -> Bool {
            switch (lhs, rhs) {
            case (.startLoading, .startLoading):
                return true
            case (.stopLoading, stopLoading):
                return true
            case (let .didLoadSuccessfully(lhsCharacterList, lhsShouldPaginate), let .didLoadSuccessfully(rhsCharacterList, rhsShouldPaginate)):
                return (lhsCharacterList == rhsCharacterList) &&
                (lhsShouldPaginate == rhsShouldPaginate)
            case (let .didFailLoading(lhsMessage), let .didFailLoading(rhsMessage)):
                return lhsMessage == rhsMessage
            default:
                return false
                
            }
        }
    }

    weak var viewController: CharacterListViewControllerProtocol?
    
    func startLoading() {
        calledMethods.append(.startLoading)
    }
    
    func stopLoading() {
        calledMethods.append(.stopLoading)
    }
    
    func didLoadSuccessfully(_ characterList: CharacterList, shouldPaginate: Bool) {
        calledMethods.append(.didLoadSuccessfully(characterList: characterList, shouldPaginate: shouldPaginate))
    }
    
    func didFailLoading(_ message: String) {
        calledMethods.append(.didFailLoading(message: message))
    }
}
