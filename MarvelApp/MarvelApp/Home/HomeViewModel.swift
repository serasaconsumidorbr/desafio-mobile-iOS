//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 21/05/23.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func isFetchingFirstData(_ bool: Bool)
    func updateCharacterList(_ characters: [HomeCharacterModel])
    func updateTopFive(_ characters: [HomeCharacterModel])
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    private let network = Network()
    private var fetchResult: RequestResultModel?
    private var homeCharacters = [HomeCharacterModel]() {
        didSet {
            self.delegate?.updateCharacterList(homeCharacters)
        }
    }
    private var topFiveCharacters = [HomeCharacterModel]()
    
    init() {
        self.delegate?.isFetchingFirstData(true)
        self.fetchRequest()
    }
    
    private func fetchRequest() {
        self.network.getAllCharacters {
            switch $0 {
            case let .failure(error):
                print(error)
            case let .success(characterResult):
                self.fetchResult = characterResult
        }
        self.populateCharactersList()
     }
    }
    
    private func populateCharactersList() {
        guard let fetchResult = fetchResult else { return }

        for character in fetchResult.data.results {
            let imgURL = URL(string:"\(character.thumbnail.path)")?.appendingPathExtension(character.thumbnail.thumbnailExtension)
            
            let isImageUnavailable = imgURL?.absoluteString.contains("image_not_available") ?? false
              
            homeCharacters.append(HomeCharacterModel(name: character.name,
                                                     image: (isImageUnavailable ? UIImage(named: "DefaultImage") : UIImage(url: imgURL)) ?? UIImage(),
                                                     description: character.description))
        }
        
        if (homeCharacters.count != 1562) {
            network.offset = homeCharacters.count
            self.fetchRequest()
        } 
        
        if (homeCharacters.count > 5 && self.topFiveCharacters.count < 5) {
            self.getTopFive()
        }
    }
    
    private func getTopFive() {
        
        for character in homeCharacters {
            let randomChar = homeCharacters.randomElement()
            //print(topFiveCharacters.count)
            if (topFiveCharacters.count == 5) {
                self.delegate?.updateTopFive(self.topFiveCharacters)
                self.delegate?.isFetchingFirstData(false)
                break
            }
  
            let alreadyHasCharacter = topFiveCharacters.contains(where: { $0.name == randomChar?.name})
        
            if (randomChar?.description != "" && !alreadyHasCharacter) {
                self.topFiveCharacters.append(randomChar ?? character)
            }
        }
    }
}
