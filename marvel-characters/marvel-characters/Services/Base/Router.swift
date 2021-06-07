//
//  Router.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Alamofire
import Foundation

protocol Router {
    var path: String { get }
    var parameters: [String: String]? { get }
    var method: HTTPMethod { get }
}
