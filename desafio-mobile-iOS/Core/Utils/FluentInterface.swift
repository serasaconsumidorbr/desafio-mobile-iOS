//
//  FluentInterface.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

// MARK:- Fluent Interface

// MARK: - With

public protocol With {}

extension With where Self: AnyObject {
    @discardableResult
    func with<T>(_ property: ReferenceWritableKeyPath<Self, T>, setValue value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}

// MARK: - Configure

public func configure<T>(
    _ value: T,
    using closure: (inout T) throws -> Void
) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}



