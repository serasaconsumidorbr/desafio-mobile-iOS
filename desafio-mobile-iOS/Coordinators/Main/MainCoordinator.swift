//
//  MainCoordinator.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

public protocol MainCoordinatorDelegate: CoordinatorDelegate {
    func didCloseScene(_ coordinator: Coordinator)
}

public class MainCoordinator: Coordinator {

    weak var coordinatorDelegate: MainCoordinatorDelegate?
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    private let mainFactory: MainFactory
    private let coordinatorFactory: CoordinatorFactory

    private var featureNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()

    init(navigationController: UINavigationController,
         delegate: MainCoordinatorDelegate,
         mainFactory: MainFactory,
         coordinatorFactory: CoordinatorFactory) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.mainFactory = mainFactory
        self.coordinatorFactory = coordinatorFactory
    }

    public func start() {
        presentMainScene()
    }

    public func finish() {

    }

    public func closeNotificationView() {
        self.childCoordinators.removeAll()
        self.coordinatorDelegate?.didCloseScene(self)
    }

    private func presentMainScene() {
        let mainViewCcontroller = mainFactory.makeMainViewController()
        let featureNavigationController = UINavigationController(rootViewController: mainViewCcontroller)
        featureNavigationController.modalPresentationStyle = .overCurrentContext
        featureNavigationController.modalTransitionStyle = .crossDissolve
        navigationController.presentedViewController?.dismiss(animated: false)
        self.featureNavigationController = featureNavigationController
        navigationController.present(featureNavigationController, animated: true)

    }

}

extension MainCoordinator: MainViewModelCoordinating {
    func showDetailScene() {}
    public func closeScene() {}
}
