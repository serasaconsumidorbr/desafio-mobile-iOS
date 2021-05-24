//
//  CharacterDetatilWorker.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import PromiseKit
import Repository

protocol CharacterDetatilWorkerLogic { 
    func getCharacterById(id: Int) -> Character?
}

final class CharacterDetatilWorker: CharacterDetatilWorkerLogic {

    lazy var repository: CharacterRepository? = {
        uCharacterDetail.container.resolve(CharacterRepository.self)
    }()
    
    func getCharacterById(id: Int) -> Character? {
        return repository?.fetchCharacterById(id: id)
    }
    
}
