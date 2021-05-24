//
//  CharacterDetatilModels.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import Repository

enum CharacterDetatil {
    
    enum GetElement {
        struct Request { }
        
        struct Response {
            let character: Character
        }
        
        struct ViewModel {
            let character: Detail
        }
    }
    
    struct Detail {
        let name: String
        let picture: String
        let description: String?
    }
    
}
