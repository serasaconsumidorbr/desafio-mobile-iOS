//
//  CharactersListConfigurator.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension CharactersListViewController {

    // MARK: - Setup
    func setup() {
        let viewController          = self
        let interactor              = CharactersListInteractor()
        let presenter               = CharactersListPresenter()
        let router                  = CharactersListRouter()

        viewController.interactor   = interactor
        viewController.router       = router
        interactor.presenter        = presenter
        presenter.viewController    = viewController
        router.viewController       = viewController
        router.dataStore            = interactor
    }

    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}
