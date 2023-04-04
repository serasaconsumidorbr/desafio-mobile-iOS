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
        
    }
    
    func didLoadSuccessfully(_ characterList: CharacterList) {
        
    }
    
    func didFailLoading(_ error: Error) {
        
    }
}
