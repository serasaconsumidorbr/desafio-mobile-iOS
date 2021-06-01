//
//  CharacterContentTableViewCell.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import UIKit

class CharacterContentTableViewCell: UITableViewCell {
    @IBOutlet weak var contentImageView: NetworkImageLoader!
    @IBOutlet weak var titleLabel: UILabel!
}

extension CharacterContentTableViewCell: ViewConfigurable {
    
    typealias ViewModel = CharacterContentTableViewCellDTO
    
    func configure(with viewModel: CharacterContentTableViewCellDTO?) {
        titleLabel.text = viewModel?.title
        if let url = viewModel?.imageURL {
           contentImageView.loadImage(from: url)
        }
    }
}
