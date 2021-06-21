//
//  HeroesHomeConfigurator.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import Foundation

class CharactersHomeConfigurator{
    static func config(vc: ViewController){
        let interactor = CharactersHomeInteractor()
        let presenter = CharactersHomePresenter()
        let router = CharactersHomeRouter()
        let worker = CharactersHomeWorker()
        presenter.controller = vc
        interactor.presenter = presenter
        interactor.worker = worker
        vc.interactor = interactor
        vc.router = router
        router.controller = vc
    }
}
