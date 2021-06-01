//
//  ViewConfigurable.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import UIKit

protocol ViewConfigurable {
    
    associatedtype ViewModel
    
    func configure(with viewModel: ViewModel?)
}
