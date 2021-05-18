//
//  MainFactoryImplementation.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Swinject

class MainFactoryImplementation: DependencyProtocol {

    private let resolver: Resolver

    required init(resolver: Resolver) {
        self.resolver = resolver
    }
}

//MARK: Implement LoanFactory
extension MainFactoryImplementation: MainFactory {

    func makeMainViewController() -> MainViewController {
        let viewModel = resolver.resolveSafe(MainViewModelProtocol.self)
        return MainViewController(viewModel: viewModel)
    }
}

