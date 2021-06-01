//
//  CharacterOptions.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

enum CharacterOption: CaseIterable {
    case favorite
    case unfavorite
}

extension CharacterOption {
    
    var title: String {
        switch self {
        case .favorite:
            return "Favorite"
        case .unfavorite:
            return "Remove from favorites"
        }
    }
    
}
