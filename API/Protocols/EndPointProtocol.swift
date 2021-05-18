//
//  EndPointProtocol.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var url: String { get }
    var method: MethodHTTP { get }
    var headers: [String : String]? { get }
    var params: [String : Any]? { get }
    var data: Data? { get }
}

extension EndpointProtocol {
    var baseURL: String {
        return ""
    }

    var url: String {
        return baseURL + path
    }

    var headers: [String : String]? {
        return nil
    }

    var params: [String : Any]? {
        return nil
    }

    var data: Data? {
        return nil
    }
}
