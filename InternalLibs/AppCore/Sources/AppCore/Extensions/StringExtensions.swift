//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation

import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG


public extension String {

    var md5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = self.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
}


public extension String.StringInterpolation {
    public mutating func appendInterpolation(nullable: Int?, leadingZeros: Int) {
        guard let value = nullable else { return }
        appendLiteral(String(format: "%0\(leadingZeros)i", value))
    }

    public mutating func appendInterpolation(nullable: Any?, inPlace: String = "") {
        guard let value = nullable else {
            appendLiteral(inPlace)
            return
        }
        appendLiteral("\(value)")
    }
}
