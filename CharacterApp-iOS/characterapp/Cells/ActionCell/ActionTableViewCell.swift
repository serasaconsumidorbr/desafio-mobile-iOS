//
//  ActionTableViewCell.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actionTitle: UILabel!
    
}


extension ActionTableViewCell: ViewConfigurable {
    
    typealias ViewModel = ActionTableViewCellDTO
    
    func configure(with viewModel: ActionTableViewCellDTO?) {
        actionTitle.text = viewModel?.actionTitle
    }
    
}

