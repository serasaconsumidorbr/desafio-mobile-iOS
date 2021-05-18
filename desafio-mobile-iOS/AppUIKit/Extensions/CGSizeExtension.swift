//
//  CGSizeExtension.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

extension CGSize {

    static func makeSize() -> CGSize {
        let screen = UIScreen.main.bounds
        let side = (screen.width / 2)
        return CGSize(width: side, height: side)
    }
}
