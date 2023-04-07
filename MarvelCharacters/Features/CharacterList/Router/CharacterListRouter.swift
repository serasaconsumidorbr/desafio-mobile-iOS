//
//  CharacterListRouter.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 06/04/23.
//

import Foundation
import UIKit

class CharacterListRouter: CharacterListRouterProtocol {
    weak var viewController: UIViewController?
    
    func showOptions(reloadDelegate: CharacterListReloadDelegate?) {
        let optionsViewController = ListOptionsConfigurator.configureView(with: reloadDelegate)
        viewController?.present(optionsViewController, animated: true)
    }
}
