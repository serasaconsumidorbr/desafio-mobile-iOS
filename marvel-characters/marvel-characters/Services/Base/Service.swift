//
//  Service.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Alamofire
import Foundation

struct Service: ServiceProtocol {
    static let shared = Service()
    
    let apiManager = APIManager()
    
    func fetch<T>(router: Router, of: T.Type, completion: @escaping (Result<T, AFError>) -> Void) where T : Decodable {
        
        let url = apiManager.getFinalURL(to: router.path)
        let parameters = apiManager.getFinalParameters(parameters: router.parameters)
        
        AF.request(url, method: router.method, parameters: parameters)
            .responseDecodable(of: T.self) { response in
                print("⬆️ \(router.method.rawValue) " + "\(String(describing: response.request))")
                
                print(response)
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200:
                        print("⬇️✅ (200) Body:")
                    default:
                        print("⬇️🅾️ (\(statusCode)) Body:")
                    }
                }
                
                
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("\(json ?? "------ NO JSON")\n\n")
                }
                
                guard let data = response.value else {
                    print(response.error ?? .explicitlyCancelled)
                    completion(.failure(response.error ?? .explicitlyCancelled))
                    return
                }
                print("\n DECODE SUCCESS")
                print(data)
                completion(.success(data))
            }
    }
}
