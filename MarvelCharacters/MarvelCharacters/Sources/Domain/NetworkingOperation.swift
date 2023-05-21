//
//  NetworkingOperation.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import Foundation
import Dispatch

public protocol NetworkingOperationType: AnyObject {
    func request<ResponseType: Codable>(request: Request, completion: @escaping(Result<ResponseType, Error>) -> ())
    func request<ResponseType: Codable>(requests: [Request], completion: @escaping (Result<[ResponseType], Error>) -> ())
}

public class NetworkingOperation: NetworkingOperationType {
    
    // MARK: - PUBLIC FUNCTIONS
    
    public func request<ResponseType: Codable>(requests: [Request], completion: @escaping (Result<[ResponseType], Error>) -> ()) {
        var responseList = [ResponseType]()
        let requestQueue = DispatchQueue(label: "com.urlDownloader.urlqueue")
        let requestGroup = DispatchGroup()
        let urls: [URLRequest] = requests.compactMap { request in
            return makeURLRequest(for: request)
        }
        
        urls.forEach { urlRequest in
            
            requestGroup.enter()
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data,
                      let responseObject = try? JSONDecoder().decode(ResponseType.self, from: data) else {
                          requestQueue.async {
                              requestGroup.leave()
                          }
                          return
                      }
                
                requestQueue.async {
                    responseList.append(responseObject)
                    requestGroup.leave()
                }
            }
            dataTask.resume()
        }
        requestGroup.notify(queue: DispatchQueue.global()) {
            completion(.success(responseList))
        }
    }
    
    public func request<ResponseType: Codable>(request: Request, completion: @escaping (Result<ResponseType, Error>) -> ())  {
        guard let urlRequest = makeURLRequest(for: request) else { return }
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                let error = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch request"])
                completion(.failure(error))
                return
            }
            guard response != nil,
                  let data = data else { return }
            
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(ResponseType.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func makeURLRequest(for request: Request) -> URLRequest? {
        var components = URLComponents()
        components.scheme = request.scheme
        components.host = request.baseURL
        components.path = request.path
        components.queryItems = request.parameters
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.name
        
        return urlRequest
    }
}
