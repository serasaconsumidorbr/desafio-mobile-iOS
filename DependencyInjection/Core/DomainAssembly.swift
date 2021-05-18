//
//  DomainAssembly.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Swinject
import SwinjectAutoregistration

class DomainAssembly: Assembly {

    func assemble(container: Container) {
        registerMainUseCases(container)
    }

    private func registerMainUseCases(_ container: Container) {
        container.register(UserDefaults.self) { _ in
            return UserDefaults.standard
        }
        registerMainCharacterUseCase(container)
    }

    private func registerMainCharacterUseCase(_ container: Container) {
        container.autoregister(MainRetrieveCharactersUseCaseProtocol.self, initializer: MainRetrieveCharactersUseCase.init)
    }

}
