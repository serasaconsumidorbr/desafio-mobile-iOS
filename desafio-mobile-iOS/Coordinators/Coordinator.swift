//
//  Coordinator.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

protocol CloseableViewModel {
    func closeScene()
}

public protocol CloseableCoordinating {
    func closeScene()
}

public protocol CoordinatorDelegate: class {

    func coordinatorDidExit(_ coordinator: Coordinator)
}

public protocol Coordinator: CoordinatorDelegate {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    func start()
    func finish()
}

extension Coordinator {

    public func finish() { }

    public func coordinatorDidExit(_ coordinator: Coordinator) {

        guard let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        self.childCoordinators.remove(at: index)

    }
}
