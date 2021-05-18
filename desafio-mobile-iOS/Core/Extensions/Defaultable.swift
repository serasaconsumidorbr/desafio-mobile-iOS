//
//  Defaultable.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

protocol Defaultable {
    static var defaultValue: Self { get }
}

extension Optional where Wrapped: Defaultable {
    var defaultValue: Wrapped { return self ?? Wrapped.defaultValue }
}

extension String: Defaultable {
    static var defaultValue: String {
        ""
    }
}

extension Bool: Defaultable {
    static var defaultValue: Bool {
        false
    }
}

extension Int: Defaultable {
    static var defaultValue: Int {
        0
    }
}

extension Int64: Defaultable {
    static var defaultValue: Int64 {
        0
    }
}

extension Array: Defaultable {
    static var defaultValue: Array {
        []
    }
}

extension Optional where Wrapped: UIImage {
    var defaultValue: UIImage {
        return self ?? UIImage()
    }
}


extension Double: Defaultable {
    static var defaultValue: Double {
        0
    }
}

extension Dictionary: Defaultable {
    static var defaultValue: Dictionary<Key, Value> {
        [:]
    }
}
