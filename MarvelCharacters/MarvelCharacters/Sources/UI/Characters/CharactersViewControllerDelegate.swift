//
//  CharactersViewControllerDelegate.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import UIKit

protocol CharactersViewControllerDelegate: AnyObject {
    func charactersViewController(didTapCharacter character: CharacterModel)
}
