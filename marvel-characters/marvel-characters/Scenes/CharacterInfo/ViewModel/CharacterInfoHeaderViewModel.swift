//
//  CharacterInfoHeaderViewModel.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

protocol CharacterInfoHeaderViewModelProtocol {
    func getCharacterName() -> String?
    func getCharacterImageInfos() -> (path: String, pathExtension: String)
}

class CharacterInfoHeaderViewModel: CharacterInfoHeaderViewModelProtocol {
    let selectedCharacter: Character
    
    init(with character: Character) {
        selectedCharacter = character
    }
    
    func getCharacterName() -> String? {
        return selectedCharacter.name
    }
    
    func getCharacterImageInfos() -> (path: String, pathExtension: String) {
        let downloadInfos = selectedCharacter.thumbnail?.getDownloadInfos()
        let infos = (
            path: downloadInfos?.path ?? "",
            pathExtension: downloadInfos?.pathExtension ?? ""
        )
        return infos
    }
}
