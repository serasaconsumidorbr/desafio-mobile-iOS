//
//  HeroesHomeConfigurator.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import Foundation

class HeroesHomeConfigurator{
    static func config(vc: ViewController){
        let interactor = HeroesHomeInteractor()
        let presenter = HeroesHomePresenter()
        let router = HeroesHomeRouter()
        presenter.controller = vc
        interactor.presenter = presenter
        vc.interactor = interactor
        vc.router = router
        router.controller = vc
    }
}
