//
//  CharacterListRouter.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit

@objc protocol CharacterListRoutingLogic {

}

protocol CharacterListDataPassing {
    var dataStore: CharacterListDataStore? { get }
}

final class CharacterListRouter: NSObject, CharacterListRoutingLogic, CharacterListDataPassing {

    // Var's
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?

}
