//
//  OnboardingRepository.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit
import Combine

protocol MavenRepositoryImpl {
        
    func getAllCharacters(page: Int?) -> AnyPublisher<Characters, APIError>
    
}

struct MavenRepository : MavenRepositoryImpl {
    
    func getAllCharacters(page: Int?) -> AnyPublisher<Characters, APIError> {
        
        var queryParams: [String: String] = [
            "ts": API.mavenTS(),
            "apikey": API.mavenPublicKey(),
            "hash": API.mavenHash()
        ]
        
        // Adicionando paginação
        if let _page = page{
            let offsetLimit = API.mavenLimit() * _page
            queryParams["limit"] = API.mavenLimit().description
            queryParams["offset"] = offsetLimit.description   
        }
        
        var components = URLComponents()
        components.scheme = API.urlScheme()
        components.host = API.urlHost()
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
                    return Fail(error: APIError.errorMesage("Ocorreu um error \(response.statusCode)")).eraseToAnyPublisher()
                }
                
            }.eraseToAnyPublisher()
        
    }
    
}
