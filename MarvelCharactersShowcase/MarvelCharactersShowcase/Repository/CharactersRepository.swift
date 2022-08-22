//
//  CharactersRepository.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 18/08/22.
//

import Foundation

class CharactersRepository {
    
    private var urlSession: URLSession
    
    static var isPaginating = false

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchCharacters(urlString: String, offset: Int = 0, completionHandler: @escaping (CharactersResponse?, ApiErrors?) -> Void) {
        
        guard let url = Formatter.FormatURL(url: urlString, offset: offset) else {
            completionHandler(nil, ApiErrors.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(nil, ApiErrors.failedRequest(description: error.localizedDescription))
                return
            }
            
            if let data = data, let characterResponseModel = try? JSONDecoder().decode(CharactersResponse.self, from: data) {
                completionHandler(characterResponseModel, nil)
                CharactersRepository.isPaginating = false
            } else {
                completionHandler(nil, ApiErrors.invalidResponseModel)
            }
        }
        
        dataTask.resume()
        
    }
    
}


