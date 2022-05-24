//
//  Constants.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

struct Constants {
    struct Credentials {
        static let apiPublicKey = "75be2dc18b6b0c6efce4716ad86842c7"
        static let apiPrivatKey = "fa7dd2f5186ecfca0bab6de882f883630411b878"

        static let timeStamp = Formatter.withDate.string(from: Date())
        static let hash = "\(timeStamp)\(apiPrivatKey)\(apiPublicKey)".md5
        
    }

    struct MarvelApi {
        static let resource = "characters?"
        static let apiKey = "apikey"
        static let hash = "hash"
        static let timeStamp = "ts"
        static let nameStartsWith = "name"
        static let limit = "limit"
        static let params = "params"
        
        
        static let urlBase = "https://gateway.marvel.com/v1/public/"
    }

    struct ParametersKeys {
        static let header = "header"
        static let method = "method"
        static let path = "path"
        static let body = "body"
        
        static let mediaType = "mediaType"
        static let timeWindow = "timeWindow"
    }

    struct HTTPMethod {
        static let get = "GET"
        static let post = "post"
        static let patch = "patch"
    }
}
