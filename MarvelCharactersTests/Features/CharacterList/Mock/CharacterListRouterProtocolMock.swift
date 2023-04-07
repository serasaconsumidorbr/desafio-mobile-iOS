//
//  CharacterListRouterProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import MarvelCharacters
import UIKit

class CharacterListRouterProtocolMock: CharacterListRouterProtocol {
    weak var viewController: UIViewController?
    
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case showOptions
    }
    
    func showOptions(reloadDelegate: CharacterListReloadDelegate?) {
        calledMethods.append(.showOptions)
    }
}
