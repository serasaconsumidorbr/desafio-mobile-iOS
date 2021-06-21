//
//  HeroesHomePresenter.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import Foundation
import UIKit

protocol CharactersHomePresentationLogic{
    func prepareCharactersNamesForPresentation(characters: [MarvelCharacter])
    func prepareCharactersImagesForPresentation(images: [UIImage])
}

class CharactersHomePresenter: CharactersHomePresentationLogic{
    var controller: ViewController?

    func prepareCharactersNamesForPresentation(characters: [MarvelCharacter]) {
        var charactersNames = [String]()
        for char in characters {
            charactersNames.append(char.name ?? "Name not found")
        }
        self.controller?.pullCharactersNames(names: charactersNames)
    }
    
    func prepareCharactersImagesForPresentation(images: [UIImage]) {
        self.controller?.pullCharactersImages(images: images)
    }
}
