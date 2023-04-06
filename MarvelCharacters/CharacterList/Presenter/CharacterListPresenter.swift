//
//  CharacterListPresenter.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

class CharacterListPresenter: CharacterListPresenterProtocol {
    weak var viewController: CharacterListViewControllerProtocol?
    
    func startLoading() {
        
    }
    
    func stopLoading() {
        viewController?.stopLoading()
    }
    
    func didLoadSuccessfully(_ characterList: CharacterList, shouldPaginate: Bool) {
        viewController?.updateDataSource(characterList, shouldPaginate: shouldPaginate)
    }
    
    func didFailLoading(_ message: String) {
        
    }
}
