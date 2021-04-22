//
//  CharacterDetailsPresenter.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharacterDetailsPresentationLogic {
    func presentSuccessFetchCharacter(response: CharacterDetails.FetchCharacter.Response.Success)
    func presentFailureFetchCharacter(response: CharacterDetails.FetchCharacter.Response.Failure)
}

final class CharacterDetailsPresenter: CharacterDetailsPresentationLogic {

    // MARK: - Var's
    weak var viewController: CharacterDetailsDisplayLogic?

    // MARK: - Func's
    func presentSuccessFetchCharacter(response: CharacterDetails.FetchCharacter.Response.Success) {
        let viewModel = CharacterDetails.FetchCharacter.ViewModel.Success(
            character: CharacterDetails.Character(id: response.characterId,
                                   name: response.characterName,
                                   description: response.characterDescription,
                                   thumbnail: response.characterThumbnail))

        viewController?.displaySuccessFetchCharacter(viewModel: viewModel)
    }

    func presentFailureFetchCharacter(response: CharacterDetails.FetchCharacter.Response.Failure) {
        let viewModel = CharacterDetails.FetchCharacter.ViewModel.Failure(error: response.error)
        viewController?.displayFailureFetchCharacter(viewModel: viewModel)
    }
}
