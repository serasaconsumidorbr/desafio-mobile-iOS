//
//  MainFlowAssembly.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Swinject

class MainFlowAssembly: Assembly {

    //MARK: Assemble
    func assemble(container: Container) {
        registerMainFactory(container)

        let coordinator = container.resolveSafe(MainCoordinator.self)
        registerMainViewModel(container, coordinator)

    }

    // MARK: Register members
    private func registerMainFactory(_ container: Container) {
        container.register(MainFactory.self) { resolver in
            MainFactoryImplementation(resolver: resolver)
        }
    }

    private func registerMainViewModel(_ container: Container, _ coordinator: MainCoordinator) {
        container.register(MainViewModelCoordinating.self) { _ in coordinator }
//        container.autoregister(MainViewModelProtocol.self, initializer: MainViewModel.init)
        container.register(MainViewModelProtocol.self) { (resolver: Resolver) in
            let viewModel = MainViewModel(useCase: resolver.resolveSafe(MainRetrieveCharactersUseCaseProtocol.self),
                                          coordinator: coordinator)
            return viewModel
        }
    }


}
