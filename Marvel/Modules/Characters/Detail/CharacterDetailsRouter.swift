//
//  CharacterDetailsRouter.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol CharacterDetailsRoutingLogic {

}

protocol CharacterDetailsDataPassing {
    var dataStore: CharacterDetailsDataStore? { get }
}

final class CharacterDetailsRouter: NSObject, CharacterDetailsRoutingLogic, CharacterDetailsDataPassing {

    // MARK: - Var's
    weak var viewController: CharacterDetailsViewController?
    var dataStore: CharacterDetailsDataStore?

    // MARK: - Func's

}
