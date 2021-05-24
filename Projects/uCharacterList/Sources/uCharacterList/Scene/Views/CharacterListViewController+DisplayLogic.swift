//
//  CharacterListViewController+DisplayLogic.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacterPage(viewModel: CharacterList.CharacterPage.ViewModel.Success)
    func displayCharacterPage(viewModel: CharacterList.CharacterPage.ViewModel.Failure)
}

extension CharacterListViewController: CharacterListDisplayLogic {

    func displayCharacterPage(viewModel: CharacterList.CharacterPage.ViewModel.Success) {
        
    }

    func displayCharacterPage(viewModel: CharacterList.CharacterPage.ViewModel.Failure) {
        
    }

}
