//
//  CharactersListServiceStub.swift
//  marvel-charactersTests
//
//  Created by Paulo Atavila on 06/06/21.
//

import Alamofire
@testable import marvel_characters

class CharactersListServiceStub: CharactersListServiceProtocol {
    var error: AFError?
    var success: CharacterDataWrapper?
    
    init(error: AFError? = nil, success: CharacterDataWrapper? = nil) {
        self.error = error
        self.success = success
    }
    
    func fetchCharctersList(offset: Int, completion: @escaping (Result<CharacterDataWrapper, AFError>) -> Void) {
        if let success = success {
            completion(.success(success))
        } else if let error = error {
            completion(.failure(error))
        } else {
            completion(.failure(.explicitlyCancelled))
        }
    }
    
    
}
