//
//  String+.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}
