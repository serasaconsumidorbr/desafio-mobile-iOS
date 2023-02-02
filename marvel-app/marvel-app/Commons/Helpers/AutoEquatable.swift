//
//  AutoEquatable.swift
//  marvel-app
//
//  Created by Leonardo Bandeira on 02/02/23.
//

import Foundation

public protocol AutoEquatable: Equatable { }

public extension AutoEquatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        var lhsDump = String()
        dump(lhs, to: &lhsDump)

        var rhsDump = String()
        dump(rhs, to: &rhsDump)

        return rhsDump == lhsDump
    }
}
