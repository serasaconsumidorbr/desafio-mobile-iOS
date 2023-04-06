//
//  ListOptionsViewControllerProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import MarvelCharacters

class ListOptionsViewControllerProtocolMock: ListOptionsViewControllerProtocol {
        
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case updateOptions(listOptions: ListOptions)
    }
    
    func updateOptions(_ listOptions: ListOptions) {
        calledMethods.append(.updateOptions(listOptions: listOptions))
    }
}
