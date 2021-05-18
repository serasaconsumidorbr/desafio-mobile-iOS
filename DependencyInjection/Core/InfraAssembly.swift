//
//  InfraAssembly.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Swinject
import SwinjectAutoregistration

class InfraAssembly: Assembly {

    func assemble(container: Container) {
        registerNetworkLayer(container)
        registerKeychainable(container)
    }

    private func registerNetworkLayer(_ container: Container) {
        container.register(APIRestProtocol.self) { _ in
            APIRest()
        }
    }

    private func registerKeychainable(_ container: Container) {
        container.register(Keychainable.self) { _ in
            KeychainKeys.shared
        }
    }
}

