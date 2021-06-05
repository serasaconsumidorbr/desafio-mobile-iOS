//
//  CharactersListRouter.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Alamofire
import Foundation

enum CharactersListRouter: Router {

    case charactersList
    
    var path: String {
        switch self {
        case .charactersList:
            return "/v1/public/characters"
        }
    }
    
    var parameters: [String : String]? {
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .charactersList:
            return .get
        }
    }
}
