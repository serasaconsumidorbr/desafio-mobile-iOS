//
//  CatalogItemCollectionViewCellDTO.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

struct CatalogItemCollectionViewCellDTO {
    let title: String?
    let imageURL: URL?
    let favorited: Bool
}

extension CatalogItemCollectionViewCellDTO {
    init(character: Character, favorited: Bool) {
        self.title = character.name
        self.imageURL = character.thumbnail?.url
        self.favorited = favorited
    }
}
