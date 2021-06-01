//
//  CatalogCoordinator.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import UIKit

class CatalogCoordinator: NavigationCoordinator {
    
    private lazy var characterCatalogBuilder: CharacterCatalogBuilder = {
        return CharacterCatalogBuilder(router: self)
    }()
  
    func start() {
        viewController.setViewControllers([characterCatalogBuilder.build()], animated: true)
    }
    
}

extension CatalogCoordinator: CharacterCatalogRouterable {
    
    func detail(for character: Character) {
        viewController.pushViewController(CharacterDetailBuilder(router: self, character: character).build(), animated: true)
    }
    
    func showOptions(_ options: [CharacterOption], for character: Character, onSelectedOption: @escaping ((CharacterOption) -> Void)) {
        
        presentAlertController { () -> UIAlertController in
            
            let alertController = UIAlertController(
                title: "\(character.name ?? "No name")",
                message: "This are the options for this character",
                preferredStyle: UIAlertController.Style.actionSheet
            )
            
            options.forEach { (option) in                
                alertController.addAction(UIAlertAction(title: option.title, style: UIAlertAction.Style.default, handler: { (action) in
                    onSelectedOption(option)
                }))
            }
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            return alertController
        }
    }
    
    func showAlert(with title: String, message: String, retry: (()->Void)?, onDismiss: (()->Void)?) {
        presentAlertController { () -> UIAlertController in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                onDismiss?()
            }))
            
            if let retry = retry {
                alertController.addAction(UIAlertAction(title: "Try again", style: .default, handler: { _ in
                    retry()
                }))
            }
            
            return alertController
        }
    }
}

extension CatalogCoordinator: CharacterDetailRouterable {
    
    
}
