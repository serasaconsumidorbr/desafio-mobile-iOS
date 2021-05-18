//
//  CoordinatorFactoryImplementation.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Swinject
import UIKit

class CoordinatorFactoryImplementation: DependencyProtocol {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: Implement CoordinatorFactory
extension CoordinatorFactoryImplementation: CoordinatorFactory {

    func makeMainCoordinator() -> MainCoordinator {
        resolver.resolveSafe(MainCoordinator.self)
    }

}
