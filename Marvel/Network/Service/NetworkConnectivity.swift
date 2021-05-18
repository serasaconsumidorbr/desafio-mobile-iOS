//
//  NetworkConnectivity.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Alamofire
import Foundation

public struct NetworkConnectivity {
    public static let sharedInstance = NetworkReachabilityManager()!
    public static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}
