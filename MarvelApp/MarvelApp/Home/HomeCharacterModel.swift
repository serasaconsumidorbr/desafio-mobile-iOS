//
//  HomeCharacterModel.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 21/05/23.
//

import UIKit

struct HomeCharacterModel: Hashable, Equatable {
    let name: String
    let image: UIImage
    let description: String?
   
    static func == (lhs: HomeCharacterModel, rhs: HomeCharacterModel) -> Bool {
       return lhs.name == rhs.name
    }
}
