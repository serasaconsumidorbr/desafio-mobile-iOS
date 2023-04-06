//
//  ListOptionsPresenterProtocolMock.swift
//  MarvelCharactersTests
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import MarvelCharacters

class ListOptionsPresenterProtocolMock: ListOptionsPresenterProtocol {
    var calledMethods: [Methods] = []
    
    enum Methods: Equatable {
        case didLoadOptions(listOptions: ListOptions)
    }

    weak var viewController: ListOptionsViewControllerProtocol?
    
    func didLoadOptions(_ listOptions: ListOptions) {
        calledMethods.append(.didLoadOptions(listOptions: listOptions))
    }
}
