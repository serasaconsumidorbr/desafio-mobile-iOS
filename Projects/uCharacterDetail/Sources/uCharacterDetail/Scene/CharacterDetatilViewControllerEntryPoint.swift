//
//  File.swift
//  
//
//  Created by Lucas Paim on 24/05/21.
//

import Foundation
import AppCoreUI



public protocol CharacterDetailViewControllerEntryPoint {
    func createCharacterDetailVC(id: Int) -> BaseViewController
}

final class CharacterDetailViewControllerEntryPointImpl: CharacterDetailViewControllerEntryPoint {
    func createCharacterDetailVC(id: Int) -> BaseViewController {
        let viewController = CharacterDetatilViewController()
        var destDS = viewController.router?.dataStore
        destDS?.id = id
        return viewController
    }
}
