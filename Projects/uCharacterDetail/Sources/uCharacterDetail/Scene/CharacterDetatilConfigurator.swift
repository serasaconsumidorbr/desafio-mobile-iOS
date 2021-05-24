//
//  CharacterDetatilConfigurator.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit

extension CharacterDetatilViewController {

    // Setup
    func setup() {
        let viewController          = self
        let interactor              = CharacterDetatilInteractor()
        let presenter               = CharacterDetatilPresenter()
        let router                  = CharacterDetatilRouter()
        let worker                  = CharacterDetatilWorker()

        viewController.interactor   = interactor
        viewController.router       = router
        interactor.presenter        = presenter
        presenter.viewController    = viewController
        router.viewController       = viewController
        router.dataStore            = interactor
        interactor.worker           = worker
    }

    // Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

}
