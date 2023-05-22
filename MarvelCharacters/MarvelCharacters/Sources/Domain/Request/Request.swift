//
//  Request.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case put
    case post
    case patch
    case delete
    
    var name: String {
        return self.rawValue.uppercased()
    }
}

public protocol Request {
    var scheme: String { get }
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
}
