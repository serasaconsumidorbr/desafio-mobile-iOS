//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation


enum NetworkConstants {
    
    static var publicKey: String? {
        Bundle.main.object(forInfoDictionaryKey: "MarvelPublicKey") as? String
    }
    
    static var privateKey: String? {
        Bundle.main.object(forInfoDictionaryKey: "MarvelPrivateKey") as? String
    }
    
    static var appVersion: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
