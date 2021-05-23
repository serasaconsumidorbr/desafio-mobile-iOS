//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import AppCore
import Alamofire

final class NetworkLogger {
    
    static var logger: Loggable? = {
        Network.container.resolve(Loggable.self)
    }()
    
    static func logSuccess(data: AFDataResponse<Any>, curl: String? = nil) {
        guard let logger = logger else { return }
        logger.info("\n - - - - - - - - - - \(nullable: data.request?.url?.absoluteString) - - - - - - - - - - \n")
        defer { logger.info("\n - - - - - - - - - -  END - - - - - - - - - - \n") }

        if let cURL = curl {
            logger.info("\n - - - - - - - - - - CURL - - - - - - - - - - \n")
            logger.info(cURL)
            logger.info("\n - - - - - - - - - - END - - - - - - - - - - \n")
        }
        
        if let request = data.request {
            logger.info("\n - - - - - - - - - - REQUEST - - - - - - - - - - \n")
            logger.info("URI: \(nullable: request.httpMethod) \(nullable: request.url?.absoluteString)\n")
            logger.info("Headers:\n\(nullable: request.allHTTPHeaderFields)\n")
            logger.info("Body:\n\(nullable: request.httpBody)\n")
            logger.info("\n - - - - - - - - - - END - - - - - - - - - - \n")
        }

        if let response = data.response {
            logger.info("\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n")
            logger.info("Status code: \(response.statusCode)\n")
            logger.info("Headers:\n\(nullable: response.allHeaderFields)\n")
            logger.info("Body:\n\(nullable: try? data.result.get())")
        }
    }

    static func logError(data: AFDataResponse<Any>, curl: String? = nil) {
        guard let logger = logger else { return }

        logger.error("\n - - - - - - - - - - \(nullable: data.request?.url?.absoluteString) - - - - - - - - - - \n")
        defer { logger.error("\n - - - - - - - - - -  END - - - - - - - - - - \n") }

        if let cURL = curl {
            logger.error("\n - - - - - - - - - - CURL - - - - - - - - - - \n")
            logger.error(cURL)
            logger.error("\n - - - - - - - - - - END - - - - - - - - - - \n")
        }
        
        if let request = data.request {
            logger.error("\n - - - - - - - - - - REQUEST - - - - - - - - - - \n")
            logger.error("URI: \(nullable: request.httpMethod) \(nullable: request.url?.absoluteString)\n")
            logger.error("Headers:\n\(nullable: request.allHTTPHeaderFields)\n")
            logger.error("Body:\n\(nullable: request.httpBody)\n")
            logger.error("\n - - - - - - - - - - END - - - - - - - - - - \n")
        }

        if let response = data.response {
            logger.error("\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n")
            logger.error("Status code: \(response.statusCode)\n")
            logger.error("Headers:\n\(nullable: response.allHeaderFields)\n")
            logger.error("Body:\n\(nullable: try? data.result.get())\n")
        }
    }

}
