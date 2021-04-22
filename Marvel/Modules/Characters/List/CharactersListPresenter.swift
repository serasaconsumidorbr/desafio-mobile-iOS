//
//  CharactersListPresenter.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharactersListPresentationLogic {
    func presentSuccessFetchCharacters(response: CharacterList.FetchCharacters.Response.Success)
    func presentFailureFetchCharacters(response: CharacterList.FetchCharacters.Response.Failure)
}

final class CharactersListPresenter: CharactersListPresentationLogic {

    // MARK: - Var's
    weak var viewController: CharactersListDisplayLogic?

    // MARK: - Func's
    func presentSuccessFetchCharacters(response: CharacterList.FetchCharacters.Response.Success) {

        let data = response.data.data.results.map { item -> CharacterList.Character in
            CharacterList.Character(id: item.id,
                                    name: item.name,
                                    description: item.resultDescription,
                                    thumbnail: "\(item.thumbnail.path).\(item.thumbnail.thumbnailExtension.rawValue)")
        }

        let viewModel = CharacterList.FetchCharacters.ViewModel.Success(
            hasNextPage: response.data.data.offset < response.data.data.total,
            data: data)
        viewController?.displaySuccessFetchCharacters(viewModel: viewModel)
    }

    func presentFailureFetchCharacters(response: CharacterList.FetchCharacters.Response.Failure) {
        let viewModel = CharacterList.FetchCharacters.ViewModel.Failure(error: response.error)
        viewController?.displayFailureFetchCharacters(viewModel: viewModel)
    }
}
