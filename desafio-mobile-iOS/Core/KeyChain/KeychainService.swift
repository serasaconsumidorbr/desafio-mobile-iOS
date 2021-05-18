//
//  KeychainService.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

private let bundle: String = Bundle.main.bundleIdentifier ?? "marvel"

enum KeychainService: String {
    case privateKey

    var name: String {
        switch self {
        case .privateKey:  return "\(bundle).PRIVATE_KEY"
        }
    }
}
