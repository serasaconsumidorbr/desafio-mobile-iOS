//
//  CardViewCell.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 21/08/22.
//

import Foundation
import UIKit

@IBDesignable

class CardViewCell: UIView {
    @IBInspectable var cornerRadius = 10.0
    @IBInspectable var shadowColor: UIColor = .white
    @IBInspectable var shadowRadius = 1.5
    @IBInspectable var shadowOpacity: Float = 1.0
    
    override func layoutSubviews() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
}
