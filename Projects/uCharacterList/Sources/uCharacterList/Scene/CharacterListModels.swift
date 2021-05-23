//
//  CharacterListModels.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import Repository

enum CharacterList {

    enum CharacterPage {
        struct Request {
            let offset: Int
            let search: String?
        }
        
        enum Response {
            struct Success {
                let characters: [Character]
                let hasNextPage: Bool
                let isFirstPage: Bool
            }
            struct Failure {
                let error: Error
            }
        }
        
        enum ViewModel {
            struct Success {
                let characters: [CharacterModel]
                let hasNextPage: Bool
                let featuredElements: [CharacterModel]
            }
            struct Failure {
                let error: Error
            }
        }
    }
    
    struct CharacterModel {
        let id: Int
        let photo: String
        let name: String
    }
    
}
