//
//  ViewController.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import UIKit

class ViewController: UIViewController {
    var router: CharactersHomeRoutingLogic?
    var interactor: CharactersHomeBusinessLogic?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharactersHomeConfigurator.config(vc: self)
        interactor?.downloadMarvelCharacters()
        
    }


}

