//
//  MainEndpoints.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

enum MainEndpoints {
    case getCharacters(offset: Int64, timestamp: String, apikey: String, hash: String)
}

extension MainEndpoints: EndpointProtocol {
    var path: String {
        switch self {
        case .getCharacters:
            return "/v1/public/characters"
        }
    }

    var method: MethodHTTP {
        return .GET
    }

    var headers: [String : String]? {
        return nil
    }

    var params: [String : Any]? {
        switch self {
        case .getCharacters(let offset, let timestamp, let apikey, let hash):
            let parameters = [
                "offset": "\(offset)",
                "ts": timestamp,
                "apikey": apikey,
                "hash": hash
            ] as [String : Any]
            return parameters
        }
    }

}
