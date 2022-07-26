//
//  HeroesCarouselCell.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

class HeroesCarouselCell: UICollectionViewCell{
    
    static var identifier: String {
        return String(describing: type(of: self))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubViews() {
        //TODO: implementar as subViews
    }
    
}
