//
//  HeroesHomeWorker.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 16/06/21.
//

import Foundation
import Alamofire


final class CharactersHomeWorker{
    let timestamp = "1335205592410"
    let apiKey = "5fad95cc0ccfc6dbdc870c3c5080ecf7"
    let hash = "5cd7ea13a73827d80f03b87c5e400568"
    lazy var marvelAPI = "https://gateway.marvel.com:443/v1/public/characters?ts=\(timestamp)&apikey=\(apiKey)&hash=\(hash)"
    
    func fetchCharacters(completion: @escaping (Result<[MarvelCharacter], Error>) -> ()){
        AF.request(marvelAPI.self).response { responseData in
            guard let data = responseData.data else {return}
            do {
                let decodableData = try JSONDecoder().decode(Root.self, from: data)
                completion(.success(decodableData.data.results))
            } catch  {
                completion(.failure(MarvelAPIError.cantDecodableApiResponse))
            }
        }
    }
}
