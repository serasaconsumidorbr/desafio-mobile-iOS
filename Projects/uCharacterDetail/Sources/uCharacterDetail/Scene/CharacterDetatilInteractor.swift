//
//  CharacterDetatilInteractor.swift
//  App
//
//  Created by Lucas Paim on 24/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit

protocol CharacterDetatilBusinessLogic {
    func getCharacterDetail(request: CharacterDetatil.GetElement.Request)
}

protocol CharacterDetatilDataStore {
    var id: Int? { get set }
}

final class CharacterDetatilInteractor: CharacterDetatilBusinessLogic, CharacterDetatilDataStore {

    // Var's
    var presenter: CharacterDetatilPresentationLogic?
    var worker: CharacterDetatilWorkerLogic?

    var id: Int?
    
    func getCharacterDetail(request: CharacterDetatil.GetElement.Request) {
        guard let id = id,
              let character = worker?.getCharacterById(id: id) else { return }
        presenter?.presentCharacterDetail(response: .init(character: character))
    }
    
}
