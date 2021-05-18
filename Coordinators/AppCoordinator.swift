//
//  AppCoordinator.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let coordinatorFactory: CoordinatorFactory

    init(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactory) {
        self.navigationController = navigationController
        self.coordinatorFactory = coordinatorFactory
    }

    public func start() {
        presentMainFLow()
    }

    private func presentMainFLow() {
        let mainCoordinator = coordinatorFactory.makeMainCoordinator()
        mainCoordinator.coordinatorDelegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }

}

extension AppCoordinator: MainCoordinatorDelegate {
    func didCloseScene(_ coordinator: Coordinator) {
    }
}
