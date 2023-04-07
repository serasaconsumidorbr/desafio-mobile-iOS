//
//  CharacterListProtocols.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import UIKit

public protocol CharacterListViewControllerProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func updateDataSource(_ characterList: CharacterList, shouldPaginate: Bool)
}

public protocol CharacterListInteractorProtocol: CharacterListReloadDelegate {
    func loadCharactersPage()
    func reloadCharacters()
}

public protocol CharacterListReloadDelegate: AnyObject {
    func reloadCharacters()
}

public protocol CharacterListPresenterProtocol: AnyObject {
    var viewController: CharacterListViewControllerProtocol? { get set }
    
    func startLoading()
    func stopLoading()
    func didLoadSuccessfully(_ characterList: CharacterList, shouldPaginate: Bool)
    func didFailLoading(_ message: String)
}

public protocol CharacterListRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showOptions(reloadDelegate: CharacterListReloadDelegate?)
}
