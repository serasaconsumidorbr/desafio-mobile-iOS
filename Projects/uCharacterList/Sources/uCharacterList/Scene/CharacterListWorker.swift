//
//  CharacterListWorker.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import PromiseKit
import Network
import Repository

protocol CharacterListWorkerLogic { 
    func fetchPage(parameters: CharacterListParameters) -> Promise<Paginated<Character>>?
}

final class CharacterListWorker: CharacterListWorkerLogic {

    lazy var repository: CharacterRepository? = {
        uCharacterList.container.resolve(CharacterRepository.self)
    }()
    
    func fetchPage(parameters: CharacterListParameters) -> Promise<Paginated<Character>>? {
        repository?.fetchCharacterList(parameters: parameters)
    }

}
