//
//  CharacterInfoViewController.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

class CharacterInfoViewController: UIViewController {
    
    private let selectedCharacter: Character
    var theView: CharacterInfoView {
        return view as! CharacterInfoView
    }
    
    init(selectedCharacter: Character) {
        self.selectedCharacter = selectedCharacter
        super.init(nibName: nil, bundle: nil)
        title = selectedCharacter.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let _ = viewModel.getCharactersList()
//        view = CharactersListView()
//        (view as? CharactersListView)?.viewModel = CharactersListViewModel()
        view = CharacterInfoView()
        theView.viewModel = CharacterInfoViewModel(character: selectedCharacter)
        
    }
    
}
