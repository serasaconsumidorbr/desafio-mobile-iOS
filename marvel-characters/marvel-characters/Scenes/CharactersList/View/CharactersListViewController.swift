//
//  CharactersListViewController.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    var theView: CharactersListView {
        return view as! CharactersListView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let _ = viewModel.getCharactersList()
        view = CharactersListView()
        theView.delegate = self
        theView.viewModel = CharactersListViewModel()
        
        title = "Marvel Characters"
    }


}

extension CharactersListViewController: CharactersListViewDelegateProtocol {
    func didSelectCharacter(_ character: Character) {
        let controller = CharacterInfoViewController(selectedCharacter: character)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didSelectFavoriteCharacter(_ favoriteCharacter: FavoriteCharacter) {
        let controller = CharacterInfoViewController(selectedCharacter: (theView.viewModel?.getCharacterAt(0))!)
        navigationController?.pushViewController(controller, animated: true)
    }
}
