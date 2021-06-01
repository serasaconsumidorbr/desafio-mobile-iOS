//
//  CharacterDetailBuilder.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

class CharacterDetailBuilder {
    
    private weak var router: CharacterDetailRouterable?
    
    var character: Character
    
    init(router: CharacterDetailRouterable, character: Character) {
        self.router = router
        self.character = character
    }
    
    func build() -> CharacterDetailViewController {
        let logic = CharacterDetailLogic(router: router)
        let viewModel = CharacterDetailViewModel(logic: logic, character: character)
        return CharacterDetailViewController(viewModel: viewModel)
    }
    
}
