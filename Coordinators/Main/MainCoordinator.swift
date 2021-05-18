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
//    private var loanDataModel: LoanDataModel?
//    private var : LoanInstallmentsOptionsResponse?

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
//        self.childCoordinators.removeAll()
//        featureNavigationController.dismiss(animated: true, completion: { [weak self] in
//            UIApplication.shared.statusBarStyle = .lightContent
//            self.featureNavigationController = nil
//        })
//        self.coordinatorDelegate?.coordinatorDidExit(self)
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

//    private func presentLoanAlertScene() {
//        let loanAlertViewController = loanFactory.makeLoanAlertViewController()
//        let featureNavigationController = BaseNavigationController(rootViewController: loanAlertViewController)
//        featureNavigationController.modalPresentationStyle = .overCurrentContext
//        navigationController.presentedViewController?.dismiss(animated: false)
//        self.featureNavigationController = featureNavigationController
//        navigationController.present(featureNavigationController, animated: true)
//    }

//    private func presentLoanScene() {
//        let defineValueViewController = loanFactory.makeLoanDefineValueViewController()
//        featureNavigationController?.pushViewController(defineValueViewController, animated: true)
//    }
//
//    private func presentInstallmentOptionsScene(loanDataModel: LoanDataModel) {
//        self.loanDataModel = loanDataModel
//        let installmentOptionsViewController = loanFactory.makeLoanInstallmentOptionsViewController(loanDataModel: loanDataModel)
//        featureNavigationController?.pushViewController(installmentOptionsViewController, animated: true)
//    }
//
//    private func presentLoanSummary(loanInstallment: LoanInstallmentsOptionsResponse) {
//        guard let loanDataModel = loanDataModel else {
//            return
//        }
//        let loanSummaryViewController = loanFactory.makeLoanSummaryViewController(loanInstallment: loanInstallment,
//                                                                                  loanDataModel: loanDataModel)
//        featureNavigationController?.pushViewController(loanSummaryViewController, animated: true)
//    }
//
//    public func dismissAll() {
//        navigationController.dismiss(animated: true)
//        coordinatorDelegate?.coordinatorDidExit(self)
//    }
//
//    private func dismiss() {
//        featureNavigationController?.dismiss(animated: true)
//        coordinatorDelegate?.coordinatorDidExit(self)
//    }
//
//    private func showSecurityFlow() {
//        guard let cvvConfiguration = buildCVVConfiguration(title: Localize.PIXTransferCVV.navTitle.localized) else {
//            return
//        }
//        // if coordinator already exists on the child coordinators array, just present the scene
//        if let coordinator = self.childCoordinators.first(where: { $0 is SecurityCoordinator }) as? SecurityCoordinator {
//            coordinator.navigationController = navigationController
//            coordinator.coordinatorDelegate = self
//            coordinator.presentCVVScene(configuration: cvvConfiguration)
//            return
//        }
//
//        let coordinator = coordinatorFactory.makeSecurityCoordinator()
//        guard let featureController = featureNavigationController else { return }
//        coordinator.navigationController = featureController
//        coordinator.coordinatorDelegate = self
//        coordinator.presentCVVScene(configuration: cvvConfiguration)
//        childCoordinators.append(coordinator)
//    }
//
//    private func buildCVVConfiguration(title: String) -> InsertCVVConfiguration? {
//        guard let plastico = ClienteModel.shared.plasticoAtual else {
//            return nil
//        }
//        let cvvConfiguration = InsertCVVConfiguration(card: plastico,
//                                                      title: title,
//                                                      isBackToRootViewController: false,
//                                                      isFromOnlinePayment: false,
//                                                      isNavigationClean: false)
//        return cvvConfiguration
//    }
//
//
//    private func showSuccessLoanScene() {
//        let parameters = ParametersNotification(title: Localize.LoanNotificationView.title.localized,
//                                                message: Localize.LoanNotificationView.message.localized,
//                                                destque: [],
//                                                titleButton: Localize.LoanNotificationView.titleButton.localized)
//        let controller = loanFactory.makeSuccessController(parameters: parameters)
//        controller.coordinator = self
//        featureNavigationController?.pushViewController(controller, animated: true)
//    }
//
//    private func showLoanReceipt(loanInstallment: LoanInstallmentsOptionsResponse) {
//        guard let loanDataModel = loanDataModel else {
//            return
//        }
//        let loanReceiptViewController = loanFactory.makeLoanReceiptViewController(loanInstallment: loanInstallment,
//                                                                                  loanDataModel: loanDataModel)
//        featureNavigationController?.pushViewController(loanReceiptViewController, animated: true)
//    }
//
//}
//
//extension LoanCoordinator: LoanDefineValueCoordinating {
//    public func closeScene() {
//        finish()
//    }
//
//    func showinstallmentOptions(loanDataModel: LoanDataModel) {
//        presentInstallmentOptionsScene(loanDataModel: loanDataModel)
//    }
//}
//
//extension LoanCoordinator: LoanInstallmentOptionsCoordinating {
//    func showLoanSummary(loanInstallment: LoanInstallmentsOptionsResponse, loanDataModel: LoanDataModel) {
//        self.loanDataModel = loanDataModel
//        presentLoanSummary(loanInstallment: loanInstallment)
//    }
//}
//
//extension LoanCoordinator: LoanSummaryViewModelCoordinating {
//
//    func didShowSecurityScene(loanDataModel: LoanDataModel) {
//        self.loanDataModel = loanDataModel
//        showSecurityFlow()
//    }
//}
//
//extension LoanCoordinator: SecurityCoordinatorDelegate {
//    func didValidateCVV(coordinator: SecurityCoordinator, _ response: CVVResponse) {
//        guard let loanData = self.loanDataModel,
//              let plastico = ClienteModel.shared.plasticoAtual,
//              let configuration = response.asValidateTokenConfiguration(card: plastico, title: Localize.LoanConfirmCVV.navTitle.localized) else {
//            return
//        }
//
//        let loanStrategy = LoanEffectiveViewModel(loanDataModel: loanData, configuration: configuration)
//        coordinator.presentTokenScene(strategy: loanStrategy, operacao: OperacaoToken.emprestimo)
//    }
//
//    func didValidateToken(_ response: ValidateTokenResponse) {
//        debugPrint(response)
//        guard let response = response as? LoanInstallmentsOptionsResponse else {
//            return
//        }
//        self.loanInstallmentsOptionsResponse = response
//        showSuccessLoanScene()
//    }
//
//    func didFinish(_ coordinator: Coordinator) {
//        self.coordinatorDidExit(coordinator)
//        self.finish()
//    }
//}
//
//extension LoanCoordinator: NotificationCoordinating {
//    func backToTimeline() {
//        closeNotificationView()
//    }
//
//    func executeNotificationAction() {
//        guard let optionsResponse = self.loanInstallmentsOptionsResponse else {
//            return
//        }
//        showLoanReceipt(loanInstallment: optionsResponse)
//    }

}

//extension LoanCoordinator: LoanReceiptViewModelCoordinating {}

//extension LoanCoordinator: LoanAlertCoordinating {

//    func showLoanScene() {
//        presentLoanScene()
//    }
//}


extension MainCoordinator: MainViewModelCoordinating {
    func showDetailScene() {}
    public func closeScene() {}
}
