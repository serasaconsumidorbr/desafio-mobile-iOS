//
//  CharacterListProtocols.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

public protocol CharacterListViewControllerProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func updateDataSource(_ characterList: CharacterList, shouldPaginate: Bool)
}

public protocol CharacterListInteractorProtocol: AnyObject {
    func loadCharacters(shouldPaginate: Bool)
}

public protocol CharacterListPresenterProtocol: AnyObject {
    var viewController: CharacterListViewControllerProtocol? { get set }
    
    func startLoading()
    func stopLoading()
    func didLoadSuccessfully(_ characterList: CharacterList, shouldPaginate: Bool)
    func didFailLoading(_ error: Error)
}
