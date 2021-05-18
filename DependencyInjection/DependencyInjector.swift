//
//  DependencyInjector.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit
import Swinject
import SwinjectAutoregistration

class DependencyInjector {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func build(completion: (_ appCoordinator: AppCoordinator, _ assembler: Assembler) -> ()) {
        let assembler = Assembler([
            CoordinatorAssembly(navigationController: self.navigationController),
            MainFlowAssembly(),
            DomainAssembly(),
            ServicesAssembly(),
            InfraAssembly()
        ])

        let appCoordinator = assembler.resolver.resolveSafe(AppCoordinator.self)
        completion(appCoordinator, assembler)
    }

}
