//
//  MarvelEndpoint.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 31/01/23.
//

import Foundation

enum MarvelEndpoint: NetworkEndpoint {
    case personagem
    
    var path: String {
        switch self {
        case .personagem:
            return "/v1/public/characters"
        }
    }
}
