//
//  CharactersListViewController.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

class CharactersListViewController: UIViewController {

    let viewModel = CharactersListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = viewModel.getCharactersList()
    }


}
