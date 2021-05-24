//
//  CharacterDetatilPresenter.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit

protocol CharacterDetatilPresentationLogic {
    func presentCharacterDetail(response: CharacterDetatil.GetElement.Response)
}

final class CharacterDetatilPresenter: CharacterDetatilPresentationLogic {

    // Var's
    weak var viewController: CharacterDetatilDisplayLogic?

    func presentCharacterDetail(response: CharacterDetatil.GetElement.Response) {
        let item = response.character
        viewController?.displayCharacterDetail(viewModel: .init(character: .init(name: item.name, picture: item.thumbnail, description: item.description)))
    }
}
