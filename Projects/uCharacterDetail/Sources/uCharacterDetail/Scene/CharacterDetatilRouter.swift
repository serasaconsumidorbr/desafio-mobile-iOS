//
//  CharacterDetatilRouter.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit

@objc protocol CharacterDetatilRoutingLogic {

}

protocol CharacterDetatilDataPassing {
    var dataStore: CharacterDetatilDataStore? { get }
}

final class CharacterDetatilRouter: NSObject, CharacterDetatilRoutingLogic, CharacterDetatilDataPassing {

    // Var's
    weak var viewController: CharacterDetatilViewController?
    var dataStore: CharacterDetatilDataStore?

}
