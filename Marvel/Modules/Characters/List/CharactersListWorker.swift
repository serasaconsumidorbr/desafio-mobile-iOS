//
//  CharactersListWorker.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

final class CharactersListWorker {

    // MARK: - Var's
    lazy var network = NetworkManager()

    // MARK: - Func's
    func fetchCharacters(offset: Int) -> Promise<MarvelObject<MarvelPaginatedObject<FetchCharactersResponse>>> {
        let parameters = FetchCharactersParameters(offset: offset)

        return network.characters.request(from: .fetchCharacters(parameters: parameters),
                                     responseType: MarvelObject<MarvelPaginatedObject<FetchCharactersResponse>>.self)
    }
}
