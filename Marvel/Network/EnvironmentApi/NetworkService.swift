//
//  NetworkService.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation

public enum NetworkService {
    case characters

    var path: String {
        switch self {
        case .characters:
            return apiVersion + "characters"
        }
    }

    var apiVersion: String {
        switch self {
        case .characters:
            return "v1/public/"
        }
    }
}
