//
//  CharacterDetailsModels.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CharacterDetails {
    enum CharacterError: DefaultError {
        case characterNotFound

        var errorType: ErrorType { .inner }
        var customErrorMessage: ErrorMessageString { ErrorMessages.genericError }
    }

    struct Character: Equatable {
        let id: Int
        let name: String
        let description: String
        let thumbnail: String

        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    enum FetchCharacter {
        struct Request { }
        enum Response {
            struct Success {
                let characterId: Int
                let characterName: String
                let characterDescription: String
                let characterThumbnail: String
            }
            struct Failure {
                let error: Error
            }
        }
        enum ViewModel {
            struct Success {
                let character: Character
            }
            struct Failure {
                let error: Error
            }
        }
    }
}
