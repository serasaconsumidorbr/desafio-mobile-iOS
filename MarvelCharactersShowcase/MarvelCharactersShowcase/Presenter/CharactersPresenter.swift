//
//  CharactersPresenter.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 19/08/22.
//

import Foundation

protocol CharactersPresenterDelegate {
    func fetchCharacters()
}

class CharactersPresenter: CharactersPresenterDelegate {
    
    let repository = CharactersRepository()
    let viewController: CharactersViewControllerDelegate?
    
    init(viewController: CharactersViewControllerDelegate?) {
        self.viewController = viewController
    }
    
    func fetchCharacters() {
        repository.fetchCharacters(urlString: K.charactersUrl) { response, error in
            
            guard let viewModel = response?.data?.results else {
                return
            }
            
            self.viewController?.showCharacters(viewModel: viewModel)
        }
    }
    
}
