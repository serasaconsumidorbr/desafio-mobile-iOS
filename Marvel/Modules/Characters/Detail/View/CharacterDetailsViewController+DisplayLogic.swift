//
//  CharacterDetailsViewController+DisplayLogic.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharacterDetailsDisplayLogic: class {
    func displaySuccessFetchCharacter(viewModel: CharacterDetails.FetchCharacter.ViewModel.Success)
    func displayFailureFetchCharacter(viewModel: CharacterDetails.FetchCharacter.ViewModel.Failure)
}

extension CharacterDetailsViewController: CharacterDetailsDisplayLogic {
    func displaySuccessFetchCharacter(viewModel: CharacterDetails.FetchCharacter.ViewModel.Success) {
        imageView.loadImage(urlString: viewModel.character.thumbnail)
        lblName.text = viewModel.character.name
        lblDescription.text = viewModel.character.description
    }

    func displayFailureFetchCharacter(viewModel: CharacterDetails.FetchCharacter.ViewModel.Failure) {
        debugPrint(viewModel.error)
    }
}
