//
//  DictionaryExtensions.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation

extension Dictionary {
    mutating public func update(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}
