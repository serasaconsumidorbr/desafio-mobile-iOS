//
//  APIManager.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

enum BuildType {
    case useKeys, ignoreKeys
}

struct APIManager {
    private let publicKey: String
    private let privateKey: String
    private let baseURL = "http://gateway.marvel.com"
    private let buildType: BuildType = .useKeys
    
    init() {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
                keys = NSDictionary(contentsOfFile: path)
            }
        if let dict = keys, buildType == .useKeys {
            publicKey = dict["publicKey"] as? String ?? ""
            privateKey = dict["privateKey"] as? String ?? ""
        } else {
            publicKey = String()
            privateKey = String()
        }
    }
    
    func getFinalURL(to path: String) -> String {
        return baseURL + path
    }
    
    func getFinalParameters(parameters: [String: String]?) -> [String: String] {
        let ts = Date.currentTimeStamp
        let hash = (String(ts) + privateKey + publicKey).asMD5Hash
        
        var result: [String: String] = [
            "ts": String(ts),
            "apikey": publicKey,
            "hash": hash
        ]
        if let parameters = parameters {
            parameters.forEach { parameter in
                result.updateValue(parameter.value, forKey: parameter.key)
            }
        }
        return result
    }
}
