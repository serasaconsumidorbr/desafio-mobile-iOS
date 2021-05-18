//
//  CoordinatorAssembly.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Swinject
import UIKit

class CoordinatorAssembly: Assembly {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Assemble

    func assemble(container: Container) {
        container.register(CoordinatorFactory.self) { resolver in
            CoordinatorFactoryImplementation(resolver: resolver)
        }

        let coordinatorFactory = container.resolveSafe(CoordinatorFactory.self)
        registerAppCoordinator(container, coordinatorFactory)
        let appCoordinator = container.resolveSafe(AppCoordinator.self)
        registerMainCoordinator(container, appCoordinator)
    }

    //MARK: Register Coordinators

    private func registerAppCoordinator(_ container: Container, _ coordinatorFactory: CoordinatorFactory) {
        container.register(AppCoordinator.self) { resolver in
            let appCoordinator = AppCoordinator(navigationController: self.navigationController,
                                                coordinatorFactory: coordinatorFactory)
            return appCoordinator
        }
    }

    private func registerMainCoordinator(_ container: Container, _ appCoordinator: AppCoordinator) {
        container.register(MainCoordinator.self) { resolver in
            let mainFactory = resolver.resolveSafe(MainFactory.self)
            let coordinatorFactory = resolver.resolveSafe(CoordinatorFactory.self)
            let mainCoordinator = MainCoordinator(navigationController: appCoordinator.navigationController,
                                                  delegate: appCoordinator,
                                                  mainFactory: mainFactory,
                                                  coordinatorFactory: coordinatorFactory)
            return mainCoordinator
        }
    }

}
