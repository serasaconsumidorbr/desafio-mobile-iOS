//
//  CharacterListViewControllerEntryPoint.swift
//  uCharacterList
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright © 2021 com.example.marvel. All rights reserved.
//

import Foundation
import AppCoreUI


public protocol CharacterListNavigationDelegate: AnyObject {
    func openCharacterDetail(id: Int, present: BaseViewController)
}

public protocol CharacterListViewControllerEntryPoint {
    func createCharacterListVC(navigation: CharacterListNavigationDelegate) -> BaseViewController
}

final class CharacterListViewControllerEntryPointImpl: CharacterListViewControllerEntryPoint {
    func createCharacterListVC(navigation: CharacterListNavigationDelegate) -> BaseViewController {
        let viewController = CharacterListViewController()
        viewController.navigationDelegate = navigation
        return viewController
    }
}
