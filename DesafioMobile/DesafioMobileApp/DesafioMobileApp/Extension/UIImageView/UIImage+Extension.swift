//
//  UIImage+Extension.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 01/02/23.
//

import Foundation
import UIKit

extension UIImage {
    public class var placeholderImage: UIImage? {
        return UIImage(named: "placeholderImage")?.withRenderingMode(.alwaysOriginal)
    }
    
    public class var  marvel_icon: UIImage? {
        return UIImage(named: "marvel_icon")?.withRenderingMode(.alwaysOriginal)
    }
    
    public class var marvelStudios_icon: UIImage? {
        return UIImage(named: "marvelStudios_icon")?.withRenderingMode(.alwaysOriginal)
    }
}
