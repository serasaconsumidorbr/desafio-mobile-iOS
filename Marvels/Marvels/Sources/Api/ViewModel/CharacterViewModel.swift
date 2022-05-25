//
//  CharacterViewModel.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation
import UIKit

enum ImageVariants: String {
    case portrait_small
    case portrait_medium
    case portrait_xlarge
    case portrait_fantastic
    case portrait_uncanny
    case portrait_incredible
    
    case landscape_small
    case landscape_medium
    case landscape_large
    case landscape_xlarge
    case landscape_amazing
    case landscape_incredible
}

struct CharacterViewModel {
    var model: CharacterModel?
    
    init(model: CharacterModel) {
        self.model = model
    }
    
    init() {
//        self.model = CharacterModel()
    }
    
    func getName(row: Int) -> String {
        model?.data?.results?[row].name ?? ""
    }
    
    func getDescription(row: Int) -> String {
        model?.data?.results?[row].resultDescription ?? ""
    }
    
    func getThumbnail(row: Int, imageVariants: ImageVariants) -> String {
        if model?.data?.results?[row].thumbnail?.path?.count ?? 0 > 0 {
            let ext = model?.data?.results?[row].thumbnail?.thumbnailExtension ?? ""
            let path = model?.data?.results?[row].thumbnail?.path ?? ""
            return "\(path)/\(imageVariants.rawValue).\(ext)"
        }
        
        return ""
    }
    
    var results: [Results]? {
        model?.data?.results
    }
    
    func request(completionHandler: @escaping CharacterAPICompletionHandler) {
        let resource = Constants.MarvelApi.resource
        let apiKey = "\(Constants.MarvelApi.apiKey)=\(Constants.Credentials.apiPublicKey)"
        let hash = "\(Constants.MarvelApi.hash)=\(Constants.Credentials.hash)"
        let ts = "\(Constants.MarvelApi.timeStamp)=\(Constants.Credentials.timeStamp)"
        let limit = "\(Constants.MarvelApi.limit)=1000"
        let params = "\(resource)&\(apiKey)&\(hash)&\(ts)&\(limit)"
        
        let parameters: [AnyHashable: Any] = [Constants.MarvelApi.params: params]
        let provider = CharacterProvider()
        
        provider.request(parameters: parameters) { result in
            do {
                let result = try result()
                let apiResponse = try JSONDecoder().decode(CharacterModel.self, from: result.data)
                
                completionHandler(.success(apiResponse))
            } catch {
                debugPrint(error)
                completionHandler(.failure(error))
            }
        }
    }
}

struct ResultsViewModel {
    var model: Results?
    
    init(model: Results) {
        self.model = model
    }
    
    var name: String {
        model?.name ?? ""
    }

    var resultDescription: String {
        guard let description = model?.resultDescription else { return "" }
        
        return description.count < 1 ? "" : description
    }

    func getThumbnail(imageVariants: ImageVariants) -> String {
        if model?.thumbnail?.path?.count ?? 0 > 0 {
            let ext = model?.thumbnail?.thumbnailExtension ?? ""
            let path = model?.thumbnail?.path ?? ""
            return "\(path)/\(imageVariants).\(ext)"
        }
        
        return ""
    }
}
    
   
