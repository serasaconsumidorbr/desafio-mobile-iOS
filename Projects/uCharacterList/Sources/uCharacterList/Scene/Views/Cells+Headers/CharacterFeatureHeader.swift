//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppCoreUI
import Carousel

final class CharacterFeatureHeader: BaseTableViewHeaderFooterView {
    
    lazy var carousel = AppCarouselView()
    
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(carousel.view)
        
        carousel.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
