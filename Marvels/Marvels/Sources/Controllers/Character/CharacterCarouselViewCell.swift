//
//  CharacterCarouselViewCell.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

import UIKit

class CharacterCarouselViewCell: UICollectionViewCell {
    // MARK: - Closures
    
    // MARK: - Constants
    static let identifier = "CharacterCarouselViewCell"
    
    // MARK: - Properts
    
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        setElementsVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setElementsVisual() {
        
    }
}
