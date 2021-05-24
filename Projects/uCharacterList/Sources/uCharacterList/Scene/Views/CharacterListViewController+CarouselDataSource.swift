//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import Carousel
import AppCoreUI
import AppCore
import AppColors



extension CharacterListViewController: AppCarouselDataSource, CharacterFeatureViewDelegate {
    func numberOfItems(_ carousel: AppCarouselView) -> Int {
        guard !featuredItems.isEmpty else { return 0 }
        return Int.max
    }
    
    func itemAtIndex(_ carousel: AppCarouselView, at index: Int) -> Any {
        featuredItems[index % featuredItems.count]
    }
    
    var carouselItemViewType: SwappableView.Type {
        CharacterFeatureView.self
    }
    
    func configureSwapView(view: SwappableView) {
        (view as? CharacterFeatureView)?.delegate = self
    }
    
    func openCharacterDetail(id: Int) {
        navigationDelegate?.openCharacterDetail(id: id, present: self)
    }
}
