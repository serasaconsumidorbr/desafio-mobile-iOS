//
//  KeychainWrapper.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

@propertyWrapper
struct KeychainWrapper<T> {

    private let key: String
    private let data: T

    init(key: String, data: T) {
        self.key = key
        self.data = data
    }

    var wrappedValue: T {
        get {
            return KeychainUtils.load(key, service: .privateKey) as? T ?? data
        }
        set {
            guard let _newValue = newValue as? String else { return }
            _ = KeychainUtils.save(key, _newValue, service: .privateKey)
            return
        }
    }
}
