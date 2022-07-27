//
//  String.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 26/07/22.
//

import Foundation
import CryptoKit

extension String {
    
    var MD5: String {
        let hash = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
            return hash.map{
                String(format: "%002hx", $0)
            }
            .joined()
    }
}
