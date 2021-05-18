//
//  StringExtension+Interpolation.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//

import Foundation

public extension String.StringInterpolation {
    mutating func appendInterpolation(nullable: Int?, leadingZeros: Int) {
        guard let value = nullable else { return }
        appendLiteral(String(format: "%0\(leadingZeros)i", value))
    }

    mutating func appendInterpolation(nullable: Any?, inPlace: String = "") {
        guard let value = nullable else {
            appendLiteral(inPlace)
            return
        }
        appendLiteral("\(value)")
    }
}
