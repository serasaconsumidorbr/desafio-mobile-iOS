//
//  OnboardingRepository.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit
import Combine

protocol MavenRepositoryImpl {
    
    func urlScheme() -> String
    func urlHost () -> String
    func mavenPrivateKey () -> String
    func mavenPublicKey () -> String
    func mavenTS () -> String
    func mavenHash () -> String
    func mavenLimit () -> Int
    
    func getAllCharacters(page: Int?) -> AnyPublisher<Characters, APIError>
    
}

struct MavenRepository : MavenRepositoryImpl {
    
    
    
    func getAllCharacters(page: Int?) -> AnyPublisher<Characters, APIError> {
        
        var queryParams: [String: String] = [
            "ts": self.mavenTS(),
            "apikey": self.mavenPublicKey(),
            "hash": self.mavenHash()
        ]
        
        // Adicionando paginação
        if let _page = page{
            let offsetLimit = mavenLimit() * _page
            queryParams["limit"] = mavenLimit().description
            queryParams["offset"] = offsetLimit.description   
        }
        
        var components = URLComponents()
        components.scheme = self.urlScheme()
        components.host = self.urlHost()
        components.path = "/v1/public/characters"
        components.setQueryItems(with: queryParams)
            
    
        // montar a url com o path
        let url = URL(string: components.string!)!
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<Characters, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: CharactersResult.self, decoder: JSONDecoder())
                        .mapError { _ in APIError.decodingError }
                        .flatMap { data in return Just(data.data!).eraseToAnyPublisher() }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
        
    }
    
    func mavenLimit() -> Int {
        return 20
    }

    func urlScheme() -> String {
        return "http"
    }
    
    func urlHost() -> String {
        return "gateway.marvel.com"
    }
    
    func mavenPrivateKey() -> String {
        return "94db8eda792e6708856d39dc692b1691168c4c75"
    }
    
    func mavenPublicKey() -> String {
        return "15cdf9ca9aead5525511c47bfceb13b9"
    }
    
    func mavenTS() -> String {
        return "1"
    }
    
    func mavenHash() -> String {
        return (mavenTS()+mavenPrivateKey()+mavenPublicKey()).MD5
    }
    
}
