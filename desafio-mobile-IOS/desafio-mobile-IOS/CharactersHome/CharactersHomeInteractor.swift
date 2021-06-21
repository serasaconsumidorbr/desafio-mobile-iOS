//
//  HeroesHomeInteractor.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import Foundation

protocol CharactersHomeBusinessLogic{
    func downloadMarvelCharacters()
}

class CharactersHomeInteractor: CharactersHomeBusinessLogic{
    var presenter: CharactersHomePresentationLogic?
    var worker: CharactersHomeWorker?
    
    func downloadMarvelCharacters(){
        worker?.fetchCharacters(completion: { result in
            switch result {
            case .success(let characters):
                print(characters)
            case .failure(let error):
                print(error)
            }
        })
    }
}
