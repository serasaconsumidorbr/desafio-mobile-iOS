//
//  CharactersListRouter.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol CharactersListRoutingLogic {
    func routeToCharacterDetails(id: Int, name: String, description: String, thumbnail: String)
}

protocol CharactersListDataPassing {
    var dataStore: CharactersListDataStore? { get }
}

final class CharactersListRouter: NSObject, CharactersListRoutingLogic, CharactersListDataPassing {

    // MARK: - Var's
    weak var viewController: CharactersListViewController?
    var dataStore: CharactersListDataStore?

    // MARK: - Func's
    func routeToCharacterDetails(id: Int, name: String, description: String, thumbnail: String) {
        let characterDetailsVC = CharacterDetailsViewController()
        var destDataStore = characterDetailsVC.router?.dataStore
        destDataStore?.characterId = id
        destDataStore?.characterName = name
        destDataStore?.characterDescription = description
        destDataStore?.characterThumbnail = thumbnail
        viewController?.navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}
