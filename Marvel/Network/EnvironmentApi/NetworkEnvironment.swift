//
//  NetworkEnvironment.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation

extension EndPointType {
    static public var currentOrigin: String {
        "https://gateway.marvel.com:443"
    }

    var environmentBaseURL: String {
        Self.currentOrigin + "/" + service.path
    }

    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var sharedHeader: [String: String] {
        var headers: [String: String] = [:]
//        headers["x-ratelimit-limit"] = "3600"
//        headers["x-ratelimit-remaining"] = "3587"
        return headers
    }
}
