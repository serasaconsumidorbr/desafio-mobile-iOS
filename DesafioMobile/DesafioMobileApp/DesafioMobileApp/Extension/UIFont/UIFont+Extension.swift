//
//  UIFont+Extension.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 02/02/23.
//

import Foundation
import UIKit

extension UIFont {
    public enum MarvelFont {
        case bold
        case boldItalic
        case italic
        case regular
    }
    
    public class func customFont(font: MarvelFont, size: CGFloat) -> UIFont {
        switch font {
        case .bold:
            return UIFont(name: "Marvel-Bold", size: size) ??
            UIFont.systemFont(ofSize: size, weight: .bold)
        case .boldItalic:
            return UIFont(name: "Marvel-BoldItalic", size: size) ??
            UIFont.systemFont(ofSize: size, weight: .semibold)
        case .italic:
            return UIFont(name: "Marvel-Italic", size: size) ??
            UIFont.systemFont(ofSize: size, weight: .semibold)
        case .regular:
            return UIFont(name: "Marvel-Regular", size: size) ??
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }
    }
}
