//
//  ServicesAssembly.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Swinject
import SwinjectAutoregistration

class ServicesAssembly: Assembly {

    func assemble(container: Container) {
        registerMainService(container)
    }

    private func registerMainService(_ container: Container) {
        container.autoregister(MainServiceProtocol.self, initializer: MainService.init)
    }

}
