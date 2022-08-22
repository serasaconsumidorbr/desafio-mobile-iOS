//
//  ErrorAlert.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 22/08/22.
//

import UIKit

class ErrorAlert {
    
    let vc: UIViewController
    
    init (vc: UIViewController) {
        self.vc = vc
    }
    
    func showError() {
        let alert = UIAlertController(title: "Erro", message: "Novos personagens não encontrados, tente novamente!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            CharactersRepository.isPaginating = false
        }))
        self.vc.present(alert, animated: true)
    }
}
