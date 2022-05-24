//
//  Data+.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

extension Data {
    func prettyPrintedJSONString() -> String {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(decoding: jsonData, as: UTF8.self)
        } else {
            return "Error: Cannot convert JSON to DATA"
        }
    }
}
