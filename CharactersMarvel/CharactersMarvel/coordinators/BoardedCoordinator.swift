//
//  BoardedCoordinator.swift
//  CharactersMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit

class BoardedCoordinator: Coordinator {
    
    var childCoordinator = [String:Coordinator]()
    var window: UIWindow
    var boardedNavController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        let vc = AppViewController(nibName: nil, bundle: nil)
        vc.viewModel = MarvelViewModel(repository: MarvelRepository())
        
        boardedNavController = UINavigationController(rootViewController: vc)
        boardedNavController?.navigationBar.isTranslucent = false
        
        boardedNavController?.navigationBar.topItem?.title = "Characters Marvel - API"
        
        window.rootViewController = boardedNavController
    }
    
}

