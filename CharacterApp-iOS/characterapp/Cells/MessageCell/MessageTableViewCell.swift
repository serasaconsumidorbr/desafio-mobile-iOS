//
//  MessageTableViewCell.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
}

extension MessageTableViewCell: ViewConfigurable {
    
    typealias ViewModel = MessageTableViewCellDTO
    
    func configure(with viewModel: MessageTableViewCellDTO?) {
        titleLabel.text = viewModel?.title
    }
    
}
