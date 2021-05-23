//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation


enum HttpErrors: Error {
    case invalidUri
    case noResponse
    case unableToDecode
    //for this test this is a generic error case for http request's
    //on real world cases, we must to make this more granular,
    //creating cases for bad request, forbidden, server error etc
    case errorOnServer
}
