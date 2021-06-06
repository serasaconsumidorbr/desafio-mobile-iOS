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
    func fetchCharctersList(offset: Int, completion: @escaping (Result<CharacterDataWrapper, AFError>) -> Void) {
        Service.shared.fetch(router: CharactersListRouter.charactersList(offset), of: CharacterDataWrapper.self) { result in
            completion(result)
        }
    }
}
