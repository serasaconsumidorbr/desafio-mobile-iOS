//
//  CharacterListModels.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CharacterList {
    
    struct Character: Equatable {
        let id: Int
        let name: String
        let description: String
        let thumbnail: String

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    enum FetchCharacters {
        struct Request {
            let offset: Int
        }
        enum Response {
            struct Success {
                let data: MarvelObject<MarvelPaginatedObject<FetchCharactersResponse>>
            }
            struct Failure {
                let error: Error
            }
        }
        enum ViewModel {
            struct Success {
                let hasNextPage: Bool
                let data: [Character]
            }
            struct Failure {
                let error: Error
            }
        }
    }
}
