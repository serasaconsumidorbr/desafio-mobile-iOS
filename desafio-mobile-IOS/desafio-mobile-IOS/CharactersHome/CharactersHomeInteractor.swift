//
//  HeroesHomeInteractor.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import Foundation
import UIKit

protocol CharactersHomeBusinessLogic{
    func downloadMarvelCharacters()
}

class CharactersHomeInteractor: CharactersHomeBusinessLogic{
    var presenter: CharactersHomePresentationLogic?
    var worker: CharactersHomeWorker?
    
    var charactersList: [MarvelCharacter]?
    
    func downloadMarvelCharacters(){
        worker?.fetchCharacters(completion: { result in
            switch result {
            case .success(let characters):
                self.charactersList = characters
                self.downloadCharactersImages()
                self.presenter?.prepareCharactersNamesForPresentation(characters: characters)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func downloadCharactersImages(){
        guard let characters = self.charactersList else {return}
        var images = [UIImage]()
        for char in characters {
            guard let path = char.thumbnail?.path else {return}
            worker?.downloadImageCharacter(path: path, completion: { result in
                switch result {
                case .success(let imageResponse):
                    images.append(imageResponse)
                case .failure(let error):
                    print(error)
                }
            })
            
        }
        presenter?.prepareCharactersImagesForPresentation(images: images)
    }
}
