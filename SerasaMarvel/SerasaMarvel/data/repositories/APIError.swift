//
//  APIError.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import Foundation

enum APIError : Error {
    case decodingError
    case errorCode(Int)
    case errorMesage(String)
    case unknown
}

extension APIError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .errorMesage(let msg):
            return msg
        case .unknown:
            return "The error is unknown"
        }
    }
}
