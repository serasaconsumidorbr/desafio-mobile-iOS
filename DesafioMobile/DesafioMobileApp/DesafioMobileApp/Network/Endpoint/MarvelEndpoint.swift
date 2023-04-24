//
//  MarvelEndpoint.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 18/04/23.
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
