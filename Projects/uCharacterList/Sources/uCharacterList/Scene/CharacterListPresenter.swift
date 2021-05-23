//
//  CharacterListPresenter.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import Repository

protocol CharacterListPresentationLogic {
    func presentCharacterPage(response: CharacterList.CharacterPage.Response.Success)
    func presentCharacterPage(response: CharacterList.CharacterPage.Response.Failure)
}

final class CharacterListPresenter: CharacterListPresentationLogic {

    // Var's
    weak var viewController: CharacterListDisplayLogic?

    func presentCharacterPage(response: CharacterList.CharacterPage.Response.Success) {
        var featuredItems: [CharacterList.CharacterModel] = []
        var characters = response.characters.map { convertDomainToModel(domain: $0) }
        if response.isFirstPage && !response.characters.isEmpty {
            for i in (0..<min(response.characters.count, 5)) {
                featuredItems.append(characters.remove(at: i))
            }
        }
        viewController?.displayCharacterPage(
            viewModel: .init(
                characters: characters,
                hasNextPage: response.hasNextPage,
                featuredElements: featuredItems
            )
        )
    }
    
    func presentCharacterPage(response: CharacterList.CharacterPage.Response.Failure) {
        viewController?.displayCharacterPage(viewModel: .init(error: response.error))
    }
    
    func convertDomainToModel(domain: Character) -> CharacterList.CharacterModel {
        return .init(id: domain.id, photo: domain.thumbnail, name: domain.name)
    }

}
