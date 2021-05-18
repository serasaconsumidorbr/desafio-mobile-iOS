//
//  Router.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation
import PromiseKit
import Alamofire
import UIKit

public protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
}


public final class Router<EndPoint: EndPointType>: NetworkRouter {

    lazy var manager: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.timeoutIntervalForRequest = 60
        return Alamofire.Session(configuration: config)
    }()
}
