//
//  HeroesHomeRouter.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import Foundation

protocol HeroesHomeRoutingLogic{
    func routeToHeroDetailsPopup()
}

class HeroesHomeRouter: HeroesHomeRoutingLogic{
    weak var controller: ViewController?
    
    func routeToHeroDetailsPopup() {
        // Call Hero Details Popup
    }
}
