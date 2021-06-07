//
//  CharactersListService.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import Alamofire
import Foundation

protocol CharactersListServiceProtocol {
    func fetchCharctersList(offset: Int, completion: @escaping (Swift.Result<CharacterDataWrapper, AFError>) -> Void)
}

struct CharactersListService: CharactersListServiceProtocol {
    let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.service = service
    }
    
    func fetchCharctersList(offset: Int, completion: @escaping (Result<CharacterDataWrapper, AFError>) -> Void) {
        service.fetch(router: CharactersListRouter.charactersList(offset), of: CharacterDataWrapper.self) { result in
            completion(result)
        }
    }
}
