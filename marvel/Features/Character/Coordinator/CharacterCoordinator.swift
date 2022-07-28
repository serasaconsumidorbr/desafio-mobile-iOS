//
//  HeroesCoordinator.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

class CharacterCoordinator: Coordinator {
    
    var topViewController: UIViewController?
    
    var parent: Coordinator?
    
    var children: [Coordinator]?
    
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let heroesListViewModel = CharacterListViewModel()
        let heroesListViewController = CharacterListViewController(with: heroesListViewModel)
        topViewController = heroesListViewController
        heroesListViewModel.presenter = heroesListViewController
        navigationController.setViewControllers([heroesListViewController], animated: true)
    }
}

