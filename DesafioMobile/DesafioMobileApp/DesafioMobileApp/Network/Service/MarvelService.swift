//
//  MarvelService.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 31/01/23.
//

import Foundation

protocol marvelServiceProtocol: Any {
    func fetchChracter(pages: String?, completion: @escaping(Result<CharacterWrapperModel, Error>) -> Void)
}

final class MarvelService: marvelServiceProtocol {
    func fetchChracter(pages: String?, completion: @escaping (Result<CharacterWrapperModel, Error>) -> Void) {
        
        NetworkService.shared.fetch(CharacterWrapperModel.self, endpoint: .personagem, pages: pages) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
}
