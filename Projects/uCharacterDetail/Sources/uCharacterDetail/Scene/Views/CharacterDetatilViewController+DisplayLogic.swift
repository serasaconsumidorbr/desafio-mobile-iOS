//
//  CharacterDetatilViewController+DisplayLogic.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import SDWebImage

protocol CharacterDetatilDisplayLogic: AnyObject {
    func displayCharacterDetail(viewModel: CharacterDetatil.GetElement.ViewModel)
}

extension CharacterDetatilViewController: CharacterDetatilDisplayLogic {
    func displayCharacterDetail(viewModel: CharacterDetatil.GetElement.ViewModel) {
        backgroundImage.sd_setImage(with: URL(string: viewModel.character.picture), placeholderImage: UIImage(named: "placeholer"))
        nameLabel.text = viewModel.character.name
        descriptionLabel.text = viewModel.character.description
        title = viewModel.character.name
    }
}
