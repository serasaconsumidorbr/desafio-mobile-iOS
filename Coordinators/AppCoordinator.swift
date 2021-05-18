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
//        mainCoordinator.navigationController = navigationController
        mainCoordinator.coordinatorDelegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }

//    private func presentPixFlow() {
//        let authenticationCoordinator = coordinatorFactory.makePixCoordinator()
//        authenticationCoordinator.coordinatorDelegate = self
//        authenticationCoordinator.start()
//        childCoordinators.append(authenticationCoordinator)
//    }

//    func presentCardsFlow(_ navigationController: UINavigationController, alreadyHavePassword: Bool, fde: Bool = false) {
//        let cardsCoordinator = coordinatorFactory.makeCardsCoordinator()
//        cardsCoordinator.navigationController = navigationController
//        cardsCoordinator.shouldRegisterPassword = alreadyHavePassword
//        cardsCoordinator.unlockFDE = fde
//        cardsCoordinator.start()
//        childCoordinators.append(cardsCoordinator)
//    }
//
//    public func presentDeliveryTimeFlow() {
//        let timelineLogisticsCoordinator = coordinatorFactory.makeTimelineLogisticsCoordinator()
//        timelineLogisticsCoordinator.coordinatorDelegate = self
//        timelineLogisticsCoordinator.start()
//        childCoordinators.append(timelineLogisticsCoordinator)
//    }
//
//    public func navigateToLifeProof(
//        customerCPF: String,
//        strategy: LifeProofAuthorizationStrategy,
//        viewController: UIViewController? = nil
//    ) {
//        let coordinator = makeFraudChatCoordinator(viewController: viewController)
//        coordinator.navigateToLifeProof(customerCPF: customerCPF, strategy: strategy)
//    }
//
//    public func navigateToLifeProofChat(customerData: HelpshiftCustomerData, viewController: UIViewController? = nil) {
//        let coordinator = makeFraudChatCoordinator(viewController: viewController)
//        coordinator.navigateToLifeProofChat(customerData: customerData)
//    }
//
//    public func navigateToFraudChat(customerData: HelpshiftCustomerData, viewController: UIViewController? = nil) {
//        let coordinator = makeFraudChatCoordinator(viewController: viewController)
//        coordinator.navigateToChat(customerData: customerData)
//    }
//
//    private func makeFraudChatCoordinator(viewController: UIViewController? = nil) -> FraudFlowCoordinator {
//        let coordinator = coordinatorFactory.makeFraudFlowCoordinator(navigationController: navigationController)
//        coordinator.coordinatorDelegate = self
//        coordinator.viewController = viewController
//        childCoordinators.append(coordinator)
//        return coordinator
//    }

}

//MARK: PixCoordinatorDelegate
//extension AppCoordinator: PIXTransferCoordinatorDelegate {
//    func didCloseScene(_ coordinator: Coordinator) {
//        coordinator.navigationController.dismiss(animated: true, completion: nil)
//        self.coordinatorDidExit(coordinator)
//    }
//}

//extension AppCoordinator: CardsCoordinatorDelegate {}
//
//extension AppCoordinator: PixCoordinatorDelegate {}
//extension AppCoordinator: PIXKeysManagementCoordinatorDelegate {}
//extension AppCoordinator: InvoicePrePaymentCoordinatorDelegate {}
//extension AppCoordinator: TEDEntrepagReceiptCoordinatorDelegate {}
//extension AppCoordinator: TEDToAnotherBankReceiptCoordinatorDelegate {}
//extension AppCoordinator: TimelineLogisticsDelegate {}
//extension AppCoordinator: LoanCoordinatorDelegate {}

extension AppCoordinator: MainCoordinatorDelegate {
    func didCloseScene(_ coordinator: Coordinator) {
    }
}
