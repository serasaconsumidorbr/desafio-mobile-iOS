//
//  APIError.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

enum APIError : Error {
    case decodingError
    case errorMesage(String)
    case unknown
}

extension APIError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorMesage(let msg):
            return msg
        case .unknown:
            return "The error is unknown"
        }
    }
}
