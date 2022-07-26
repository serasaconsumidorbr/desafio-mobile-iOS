//
//  HeroesCoordinator.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

class HeroesCoordinator: Coordinator {
    
    var topViewController: UIViewController?
    
    var parent: Coordinator?
    
    var children: [Coordinator]?
    
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let heroesListViewModel = HeroesListViewModel()
        topViewController = HeroesListViewController(with: heroesListViewModel)
        navigationController.pushViewController(topViewController!, animated: true)
    }
}

