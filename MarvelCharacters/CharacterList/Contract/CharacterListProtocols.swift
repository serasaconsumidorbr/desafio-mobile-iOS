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
}

public protocol CharacterListInteractorProtocol: AnyObject {
    func loadNextPage()
}

public protocol CharacterListPresenterProtocol: AnyObject {
    var viewController: CharacterListViewControllerProtocol? { get set }
    
    func startLoading()
    func stopLoading()
    func didLoadSuccessfully(_ characterList: CharacterList)
    func didFailLoading(_ error: Error)
}
