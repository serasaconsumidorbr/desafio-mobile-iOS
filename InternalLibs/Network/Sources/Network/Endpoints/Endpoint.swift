//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import Alamofire
import PromiseKit


protocol EndPoint {
    var uri: String { get }
    var path: String { get }
    var encoder: ParameterEncoding { get }
    var method: HTTPMethod { get }
    
    associatedtype ParameterType: Encodable
    associatedtype ResponseType: Decodable
}



extension EndPoint {
    func request(parameters: ParameterType) -> Promise<ResponseType> {
        fatalError()
    }
}
