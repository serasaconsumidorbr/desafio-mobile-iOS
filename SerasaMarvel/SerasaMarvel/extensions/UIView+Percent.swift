//
//  View+Percent.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 27/06/21.
//

import UIKit

extension UIView {
    
    func percentOfHeight( percente : CGFloat) -> CGFloat {
        return ((self.frame.height * percente) / 100)
    }
    
    func percentOfWidth( percente : CGFloat) -> CGFloat {
        return ((self.frame.width * percente) / 100)
    }
    
}
