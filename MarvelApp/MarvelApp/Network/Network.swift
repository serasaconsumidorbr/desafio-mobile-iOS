//
//  Network.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 21/05/23.
//

import UIKit
import CryptoKit

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

class Network {
    
    private let baseURL = "https://gateway.marvel.com:443/v1"
    public var offset = 0
    public var limit = 20
    
    private enum BaseEndpoint: String {
        case allCharacters = "/public/characters"
    }
    
    private enum Method: String {
        case GET
    }
    
    func getAllCharacters(completion: @escaping ((Result<RequestResultModel, APIError>) -> Void)) {
        self.request(endpoint: .allCharacters,
                     method: .GET,
                     completion: completion)
    }
    
    private func request<T: Codable>(endpoint: BaseEndpoint,
                                     method: Method,
                                     completion: @escaping((Result<T, APIError>) -> Void)) {
        let querys = buildUrlQuerys()
        let path = "\(baseURL)\(endpoint.rawValue)\(querys)"
        guard let url = URL(string: path) else {
            completion(.failure(.internalError)); return }
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        call(with: request, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest,
                                  completion: @escaping((Result<T, APIError>) -> Void)) {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil
               else { completion(.failure(.serverError)); return }
            do {
                guard let data = data
                  else { completion(.failure(.serverError)); return }
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                print(String(describing: error))
                completion(.failure(.parsingError))
            }
        }.resume()
    }
}

// MARK: - Helpers
extension Network {
    
    private func buildUrlQuerys() -> String {
        let apiKey = "5cf9fdf2b3c8207486863666010388e0"
        let privateKey = "2c4cf17f2748a733bf347021e710f816fff9d9ed"
        
        let date = Date()
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime]
        let timeStamp = iso8601DateFormatter.string(from: date)
        let hash = MD5(string: "\(timeStamp)\(privateKey)\(apiKey)")
        
        return "?offset=\(offset)&limit=\(limit)&ts=\(timeStamp)&apikey=\(apiKey)&hash=\(hash)"
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
