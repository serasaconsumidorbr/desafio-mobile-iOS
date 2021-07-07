//
//  API.swift
//  CharactersMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 29/06/21.
//

import Foundation

struct API {
    
    static func mavenLimit() -> Int {
        return 20
    }

    static func urlScheme() -> String {
        return "http"
    }
    
    static func urlHost() -> String {
        return "gateway.marvel.com"
    }
    
    static func mavenPrivateKey() -> String {
        return "94db8eda792e6708856d39dc692b1691168c4c75"
    }
    
    static func mavenPublicKey() -> String {
        return "15cdf9ca9aead5525511c47bfceb13b9"
    }
    
    static func mavenTS() -> String {
        return "1"
    }
    
    static func mavenHash() -> String {
        return (mavenTS()+mavenPrivateKey()+mavenPublicKey()).MD5
    }
    
}
