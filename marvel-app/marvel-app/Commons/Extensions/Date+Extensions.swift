//
//  Date+Extensions.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 31/01/23.
//

import Foundation

extension Date {
    func currentTimeInMillis() -> Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
}
