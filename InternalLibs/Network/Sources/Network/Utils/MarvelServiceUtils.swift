//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import Alamofire


extension String {
    var appendMarvelAuthParams: String? {
        guard var urlComponents = URLComponents(string: self),
              let publicKey = NetworkConstants.publicKey,
              let privateKey = NetworkConstants.privateKey else { return nil }
        let ts = 1
        let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query([
            "ts": ts,
            "apikey": publicKey,
            "hash": "\(ts)\(privateKey)\(publicKey)".md5
        ])
        urlComponents.percentEncodedQuery = percentEncodedQuery
        return urlComponents.url?.absoluteString
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        let enconding = URLEncoding.default
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += enconding.queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}
