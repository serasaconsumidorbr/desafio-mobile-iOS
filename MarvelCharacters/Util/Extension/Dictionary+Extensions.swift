//
//  Dictionary+Extensions.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Foundation

public func ==(lhs: [String: Any]?, rhs: [String: Any]?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
        return !((lhs != nil) && (rhs != nil))
    }
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}
