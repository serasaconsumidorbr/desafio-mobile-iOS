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

//    private func registerPixCoordinator(_ container: Container, _ appCoordinator: AppCoordinator) {
//        container.register(PixCoordinator.self) { resolver in
//            let pixFactory = resolver.resolveSafe(PixFactory.self)
//            let pixCoordinator = PixCoordinator(navigationController: appCoordinator.navigationController,
//                                                delegate: appCoordinator, pixFactory: pixFactory)
//            return pixCoordinator
//        }
//    }

//    private func registerCardsCoordinator(_ container: Container, _ appCoordinator: AppCoordinator) {
//        container.register(CardsCoordinator.self) { resolver in
//            let cardsFactory = resolver.resolveSafe(CardsFactory.self)
//            let cardsCoordinator = CardsCoordinator(navigationController: appCoordinator.navigationController,
//                                                    delegate: appCoordinator, cardsFactory: cardsFactory)
//            return cardsCoordinator
//        }.inObjectScope(.container)
//    }

//    private func registerKeysManagementCoordinator(_ container: Container, _ appCoordinator: AppCoordinator) {
//        container.register(PIXKeysManagementCoordinator.self) { (resolver: Resolver) in
//            let pixFactory = resolver.resolveSafe(PIXKeysManagementFactory.self)
//            let coordinatorFactory = resolver.resolveSafe(CoordinatorFactory.self)
//            let firstAccessCoordinator = PIXKeysManagementCoordinator(navigationController: appCoordinator.navigationController,
//                                                                      delegate: appCoordinator,
//                                                                      pixFactory: pixFactory,
//                                                                      coordinatorFactory: coordinatorFactory)
//            return firstAccessCoordinator
//        }.inObjectScope(.container)
//    }

//    private func registerTransferCoordinator(_ container: Container) {
//        container.register(PIXTransferCoordinator.self) { (resolver: Resolver, navController: UINavigationController) in
//            let factory = resolver.resolveSafe(PIXTransferFactory.self)
//            let coordinatorFactory = resolver.resolveSafe(CoordinatorFactory.self)
//            let coordinator = PIXTransferCoordinator(navigationController: navController,
//                                                     factory: factory,
//                                                     coordinatorFactory: coordinatorFactory)
//            return coordinator
//        }
//    }

}
