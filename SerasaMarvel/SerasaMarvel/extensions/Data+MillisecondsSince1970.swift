//
//  Data+Milliseconds.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 26/06/21.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
