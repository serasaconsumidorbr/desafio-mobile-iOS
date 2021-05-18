//
//  MainService.swift
//  Marvel
//
//  Created by andre mietti on 16/05/21.
//

import Foundation

class MainService {

    private let network: APIRestProtocol

    init(network: APIRestProtocol) {
        self.network = network
    }

}

extension MainService: MainServiceProtocol {

    func retrieveMarvelCharacters(offset: Int64, completion: @escaping GenericResult<CharacterDataResponse>) {
        let intTs = Int(NSDate().timeIntervalSince1970)
        let timestamp = String(intTs)
        network.execute(endpoint: MainEndpoints.getCharacters(offset: offset, timestamp: timestamp, apikey: Keys.pubKey.rawValue, hash: Crypto.getAuthorization(ts: timestamp))) { (success: Bool, response: ResponseData<CharacterDataResponse>?, error: ErrorData<ErrorSpringCodable>?) in
            DispatchQueue.main.async {
                if let error = error?.errorValue {
                    completion(.failure(error.asError))
                    return
                }
                guard success, let data = response?.data else {
                    completion(.failure(ResponseError.defaultError()))
                    return
                }
                completion(.success(data))
            }
        }
    }

}
