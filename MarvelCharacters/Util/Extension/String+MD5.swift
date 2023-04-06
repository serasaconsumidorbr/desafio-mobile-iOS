//
//  String+MD5.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation
import CryptoKit

// https://powermanuscript.medium.com/swift-5-2-macos-md5-hash-for-some-simple-use-cases-66be9e274182
extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
