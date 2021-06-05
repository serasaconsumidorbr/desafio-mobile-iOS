//
//  Date+TimeStamp.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Foundation

extension Date {
    static var currentTimeStamp: Int64 {
        return Int64(Date().timeIntervalSince1970)
    }
}
