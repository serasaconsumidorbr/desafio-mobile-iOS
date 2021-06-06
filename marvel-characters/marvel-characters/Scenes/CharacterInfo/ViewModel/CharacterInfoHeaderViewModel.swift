//
//  CharacterInfoHeaderViewModel.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

protocol CharacterInfoHeaderViewModelProtocol {
    func getCharacterName() -> String?
    func getCharacterImage() -> UIImage
}

class CharacterInfoHeaderViewModel: CharacterInfoHeaderViewModelProtocol {
    let selectedCharacter: Character
    
    init(with character: Character) {
        selectedCharacter = character
    }
    
    func getCharacterName() -> String? {
        return selectedCharacter.name
    }
    
    func getCharacterImage() -> UIImage {
        return UIImage(imageLiteralResourceName: "marvel")
    }
}
