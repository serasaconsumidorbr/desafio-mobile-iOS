//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import UIKit

public protocol SwappableView: AnyObject {
    var viewRef: UIView? { get }
    init()
    func presentData(data: Any)
    func presentByBroadcast(data: Any)
}
