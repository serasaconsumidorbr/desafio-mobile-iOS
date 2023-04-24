//
//  NetworkService.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 18/04/23.
//

import UIKit
import Foundation
import CryptoKit
import SystemConfiguration

struct NetworkConstant {
    static let baseURL: String = "http://gateway.marvel.com"
}

enum NetworkError: Error {
  case invalidResponse
  case decoding(Error)
  case statusCode(Int)
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let privateKey: String = "688635c9ede93f05a0ef15fc33371b0b2352ba9b"
    private let publicKey: String = "88aca1efa60aec36df609574f1dee7c1"
    
    private func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = md5(data: "\(ts)\(privateKey)\(publicKey)")
        return "&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    func fetch<T>(_:T.Type, endpoint: MarvelEndpoint, pages: String?, completion: @escaping(Result<T, Error>) -> Void) where T: Decodable {
        var urlRequest = endpoint.baseURL
        urlRequest.path.append(endpoint.path)
        
        let queryItems = [URLQueryItem(name: "limit", value: "100"),
                          URLQueryItem(name: "offset", value: pages)]
        urlRequest.queryItems = queryItems
        
        guard let urlFinal = urlRequest.url else { return print("n deu certo")}
        
        
        guard let url = URL(string: "\(urlFinal)\(getCredentials())") else { return }
        
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            switch response.statusCode {
            case 200...299:
                do {
                    let dataDecoded = try decoder.decode(T.self, from: data)
                    completion(.success(dataDecoded))
                } catch {
                    completion(.failure(NetworkError.decoding(error)))
                }
            default:
                completion(.failure(NetworkError.statusCode(response.statusCode)))
            }
        })
        task.resume()
    }
    
    private func md5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}
