//
//  AppCoordinator.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var topViewController: UIViewController?
    
    var navigationController: UINavigationController
    
    private(set) static var shared: AppCoordinator?
    weak var parent: Coordinator?
    var children: [Coordinator]? = []
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        if AppCoordinator.shared == nil {
            AppCoordinator.shared = self
        } else {
            fatalError("AppCoordinator already initialized")
        }
    }
    
    func start() {
        let heroesCoordinator = CharacterCoordinator(navigationController)
        attachChild(heroesCoordinator, completion: {
            heroesCoordinator.start()
        })
    }
    
}
