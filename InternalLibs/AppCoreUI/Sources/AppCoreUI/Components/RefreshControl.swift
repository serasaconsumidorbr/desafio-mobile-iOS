//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors


public final class RefreshControlBuilder {
    static public func build() -> UIRefreshControl {
        let refresh = UIRefreshControl()
        refresh.tintColor = .appBackgroundColor
        return refresh
    }
}
