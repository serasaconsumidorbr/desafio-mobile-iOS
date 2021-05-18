//
//  MainServiceProtocol.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

protocol MainServiceProtocol {
    func retrieveMarvelCharacters(offset: Int64, completion: @escaping GenericResult<CharacterDataResponse>)
}
