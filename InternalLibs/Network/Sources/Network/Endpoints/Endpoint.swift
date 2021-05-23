//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import Alamofire
import PromiseKit
import AppCore

protocol EndPoint {
    var uri: String { get }
    var path: String { get }
    var encoder: ParameterEncoding { get }
    var method: HTTPMethod { get }
    
    associatedtype ParameterType: Encodable
    associatedtype ResponseType: Decodable
}


fileprivate class AlamofireSession {
    lazy var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.httpAdditionalHeaders = [
            "User-Agent": "LPaim/Alamofire/iOS:MarvelApp-\(NetworkConstants.appVersion!)"
        ]
        return Session(configuration: configuration)
    }()
    
    static let instance = AlamofireSession()
}


extension EndPoint {
    

    
    fileprivate var loggable: Loggable? {
        Network.container.resolve(Loggable.self)
    }
    
    func request(parameters: ParameterType) -> Promise<ResponseType> {
        Promise<ResponseType> { seal in
            guard let urlString = "\(Network.ServerUri)\(path)".appendMarvelAuthParams,
                  let url = Foundation.URL(string: urlString) else {
                seal.reject(HttpErrors.invalidUri)
                return
            }
            
            let request = AlamofireSession.instance.session.request(url, method: method, parameters: parameters.dictionary, encoding: encoder)
            
            request.responseJSON(completionHandler: { response in
                    
                    guard let remoteResponse = response.response else {
                        loggable?.error(response.error.debugDescription)
                        seal.reject(HttpErrors.noResponse)
                        return
                    }
                    
                    switch(remoteResponse.statusCode) {
                    case 200..<300:
                        NetworkLogger.logSuccess(data: response, curl: request.cURLDescription())
                        guard let data = response.data,
                              let decodedResponse: ResponseType = decode(response: data) else {
                            seal.reject(HttpErrors.unableToDecode)
                            return
                        }
                        seal.fulfill(decodedResponse)
                    default:
                        NetworkLogger.logError(data: response, curl: request.cURLDescription())
                        seal.reject(HttpErrors.errorOnServer)
                    }
                    
                })
        }
    }
    
    fileprivate func decode<T: Decodable>(response: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: response)
        } catch {
            loggable?.error(error)
        }
        return nil
    }
}
