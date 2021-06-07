//
//  Service.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Alamofire
import Foundation

struct Service: ServiceProtocol {
    let apiManager = APIManager()
    
    private let manager: Session
    init(manager: Session = Session.default) {
        self.manager = manager
    }
    
    func fetch<T>(router: Router, of: T.Type, completion: @escaping (Result<T, AFError>) -> Void) where T : Decodable {
        
        let url = apiManager.getFinalURL(to: router.path)
        let parameters = apiManager.getFinalParameters(parameters: router.parameters)
        
        manager.request(url, method: router.method, parameters: parameters)
            .responseDecodable(of: T.self) { response in
                guard let data = response.value else {
                    completion(.failure(response.error ?? .explicitlyCancelled))
                    return
                }
                completion(.success(data))
            }
    }
}
