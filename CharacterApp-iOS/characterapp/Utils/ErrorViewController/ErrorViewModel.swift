//
//  ErrorViewModel.swift
//  characterapp
//
//  Created by Denys Galante on 01/06/2021.
//  Copyright © 2021 Denys Galante. All rights reserved.
//

import Foundation

struct ErrorViewModel {
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    init(message: String) {
        self.message = message
        self.actionTitle = nil
        self.action = nil
    }
    
    
    init(message: String, actionTitle: String?, action: (() -> Void)?) {
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }
    
    init(error: NSError, actionTitle: String?, action: (() -> Void)?) {
        self.init(
            message: error.localizedDescription,
            actionTitle: actionTitle,
            action: action
        )
    }
}
