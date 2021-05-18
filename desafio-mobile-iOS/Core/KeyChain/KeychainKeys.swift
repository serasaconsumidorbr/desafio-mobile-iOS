//
//  KeychainKeys.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

// The data saved on the Keychain must be **String** type
protocol Keychainable {
    var privateKey: String? { get set }
}

class KeychainKeys: Keychainable {

    static let shared = KeychainKeys()

    private init () {}

    @KeychainWrapper(key: "privateKey", data: nil)
    var privateKey: String?

}
