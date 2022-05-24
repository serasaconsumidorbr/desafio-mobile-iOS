//
//  CharacterCoordinator.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation
import UIKit

class CharacterCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CharacterViewController()
        self.navigationController.pushViewController(viewController, animated: true)
        
        CharacterViewModel().request { result in
            switch result {
            case .success(let model):
                viewController.charactersViewModel = CharacterViewModel(model: model)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
