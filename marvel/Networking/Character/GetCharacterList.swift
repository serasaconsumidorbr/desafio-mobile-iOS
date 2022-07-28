//
//  GetHeroesList.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 26/07/22.
//

import Foundation
import Alamofire

class GetCharacterList {
    func getHeroesList(offset: Int, completion: @escaping (Result<CharacterList, Error>) -> Void) {
        let url = "\(MarvelKeys.mainURL)/characters?limit=10&offset=\(offset)\(MarvelKeys.hashParam)"
        
        AF
            .request(url)
            .responseDecodable(of: CharacterListWrapper.self ) { response in
                switch response.result {
                case .success(let hero):
                    completion(.success(hero.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
