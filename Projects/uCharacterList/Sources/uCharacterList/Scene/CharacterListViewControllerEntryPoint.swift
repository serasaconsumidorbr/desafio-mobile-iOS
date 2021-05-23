//
//  CharacterListViewControllerEntryPoint.swift
//  uCharacterList
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright © 2021 com.example.marvel. All rights reserved.
//

import Foundation
import AppCoreUI



public protocol CharacterListViewControllerEntryPoint {
    func createCharacterListVC() -> BaseViewController
}

final class CharacterListViewControllerEntryPointImpl: CharacterListViewControllerEntryPoint {
    func createCharacterListVC() -> BaseViewController {
        return CharacterListViewController()
    }
}
