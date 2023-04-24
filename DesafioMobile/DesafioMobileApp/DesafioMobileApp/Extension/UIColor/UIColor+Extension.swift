//
//  UIColor+Extension.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 18/04/23.
//

import Foundation
import UIKit

extension UIColor {
    
    public class var black_151514: UIColor {
        return UIColor(hex: "151514")
    }
    
    public class var white_F8F8F8: UIColor {
        return UIColor(hex: "F8F8F8")
    }
    
    public class var white_ECEAEA: UIColor {
        return UIColor(hex: "ECEAEA")
    }
    
    public class var grey_72726E: UIColor {
        return UIColor(hex: "72726E")
    }
    
    public class var background_grey: UIColor {
        return UIColor(hex: "40403B")
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }
}
