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
        case didLoadSuccessfully(characterList: CharacterList)
        case didFailLoading(error: Error)
        
        static func == (lhs: CharacterListPresenterProtocolMock.Methods, rhs: CharacterListPresenterProtocolMock.Methods) -> Bool {
            switch (lhs, rhs) {
            case (.startLoading, .startLoading):
                return true
            case (.stopLoading, stopLoading):
                return true
            case (let .didLoadSuccessfully(lhsCharacterList), let .didLoadSuccessfully(rhsCharacterList)):
                return lhsCharacterList == rhsCharacterList
            case (let .didFailLoading(lhsError), let .didFailLoading(rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
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
    
    func didLoadSuccessfully(_ characterList: CharacterList) {
        calledMethods.append(.didLoadSuccessfully(characterList: characterList))
    }
    
    func didFailLoading(_ error: Error) {
        calledMethods.append(.didFailLoading(error: error))
    }
}
