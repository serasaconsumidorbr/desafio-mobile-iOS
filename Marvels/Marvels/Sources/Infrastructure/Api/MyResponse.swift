//
//  MyResponse.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

public class MyResponse {
    var data: Data?
    var error: Error?
    var statusCode: Int
    var success: Bool?
    
    init(data: Data?, error: Error?, statusCode: Int?, success: Bool?) {
        self.data = data
        self.error =  error
        self.statusCode = statusCode ?? -1
        self.success = success
    }
}
