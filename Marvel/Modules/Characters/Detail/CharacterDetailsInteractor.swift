//
//  CharacterDetailsInteractor.swift
//  Marvel
//
//  Created by João Pedro on 22/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CharacterDetailsBusinessLogic {
    func fetchCharacterDetail(request: CharacterDetails.FetchCharacter.Request)
}

protocol CharacterDetailsDataStore {
    var characterId: Int { get set }
    var characterName: String { get set }
    var characterDescription: String { get set }
    var characterThumbnail: String { get set }
}

final class CharacterDetailsInteractor: CharacterDetailsBusinessLogic, CharacterDetailsDataStore {

    // MARK: - Var's
    var presenter: CharacterDetailsPresentationLogic?
    var worker = CharacterDetailsWorker()
    var characterId: Int  = 0
    var characterName: String = ""
    var characterDescription: String = ""
    var characterThumbnail: String = ""

    // MARK: - Func's
    func fetchCharacterDetail(request: CharacterDetails.FetchCharacter.Request) {
        guard self.characterId != 0  else {
            let error = CharacterDetails.CharacterError.characterNotFound
            let response = CharacterDetails.FetchCharacter.Response.Failure(error: error)
            presenter?.presentFailureFetchCharacter(response: response)
            return
        }

        let response = CharacterDetails
            .FetchCharacter
            .Response
            .Success(characterId: characterId,
                     characterName: characterName,
                     characterDescription: characterDescription,
                     characterThumbnail: characterThumbnail)

        presenter?.presentSuccessFetchCharacter(response: response)
    }
}
