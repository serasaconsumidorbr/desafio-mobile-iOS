//
//  ServiceProtocol.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Alamofire
import Foundation

protocol ServiceProtocol {
    func fetch<T: Decodable>(router: Router, of: T.Type, completion: @escaping (Swift.Result<T, AFError>) -> Void)
}
