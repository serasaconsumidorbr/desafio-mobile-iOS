//
//  CharactersViewController.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 18/08/22.
//

import UIKit

protocol CharactersViewControllerDelegate {
    func showCharacters(viewModel: [Character])
}

class CharactersViewController: UIViewController, CharactersViewControllerDelegate {

    var presenter: CharactersPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CharactersPresenter(viewController: self)
        presenter?.fetchCharacters()
    }
    
    func showCharacters(viewModel: [Character]) {
        //TODO: Populate TableView and CollectionView
        print(viewModel)
    }

}

