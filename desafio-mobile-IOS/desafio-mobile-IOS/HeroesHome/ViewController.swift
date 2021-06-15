//
//  ViewController.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import UIKit

class ViewController: UIViewController {
    var router: HeroesHomeRoutingLogic?
    var interactor: HeroesHomeBusinessLogic?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeroesHomeConfigurator.config(vc: self)
    }


}

