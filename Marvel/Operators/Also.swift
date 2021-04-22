//
//  Also.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation

infix operator <-< : AssignmentPrecedence

@discardableResult
public func <-< <T: AnyObject>(left: T, right: (T) -> Void) -> T {
    right(left)
    return left
}
