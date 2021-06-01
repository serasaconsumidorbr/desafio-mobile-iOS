//
//  CharacterCatalogBuilder.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

class CharacterCatalogBuilder {
    
    private weak var router: CharacterCatalogRouterable?
    
    init(router: CharacterCatalogRouterable) {
        self.router = router
    }
    
    func build() -> CharacterCatalogViewController {
        let logic = CharacterCatalogLogic(router: router)
        let viewModel = CharacterCatalogViewModel(logic: logic)
        return CharacterCatalogViewController(viewModel: viewModel)
    }
    
}
