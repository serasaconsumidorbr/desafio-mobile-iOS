//
//  CharacterModel.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import Foundation

public struct CharacterModel {
    let id: String
    let name: String?
    let description: String?
    let imagePath: String?
    let imageExtension: String?
    
    func getImageUrl() -> String {
        guard let imagePath = imagePath,
              let imageExtension = imageExtension else {
            return ""
        }
        return "\(imagePath)\(imageExtension)"
    }
}
