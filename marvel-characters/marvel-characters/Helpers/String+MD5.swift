//
//  String+MD5.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation
import CryptoKit

extension String {
    var asMD5Hash: String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}
