//
//  CharactersListViewController+DisplayLogic.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharactersListDisplayLogic: class {
    func displaySuccessFetchCharacters(viewModel: CharacterList.FetchCharacters.ViewModel.Success)
    func displayFailureFetchCharacters(viewModel: CharacterList.FetchCharacters.ViewModel.Failure)
}

extension CharactersListViewController: CharactersListDisplayLogic {
    func displaySuccessFetchCharacters(viewModel: CharacterList.FetchCharacters.ViewModel.Success) {
        tableViewProxy.haveNextPage = viewModel.hasNextPage
        viewModel.data.forEach { item in
            if let oldIndex = items.firstIndex(of: item) {
                items.remove(at: oldIndex)
                items.insert(item, at: oldIndex)
            } else {
                items.append(item)
            }
        }

        tableViewProxy.currentState = items.isEmpty ? .empty : .none
    }

    func displayFailureFetchCharacters(viewModel: CharacterList.FetchCharacters.ViewModel.Failure) {
        tableViewProxy.currentState = .retryError
    }
}
