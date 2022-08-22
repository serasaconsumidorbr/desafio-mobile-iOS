//
//  ApiErrors.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 19/08/22.
//

import Foundation

enum ApiErrors: Error, Equatable {
    
    case invalidURL
    case invalidResponseModel
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidURL:
            return "URL Error"
        case .invalidResponseModel:
            return "Error parsing response"
        }
    }
    
}
