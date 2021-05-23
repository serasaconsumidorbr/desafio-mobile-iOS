//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import UIKit

// MARK: - AppCarouselDataSource
public protocol AppCarouselDataSource: AnyObject {
    func numberOfItems(_ carousel: AppCarouselView) -> Int
    func itemAtIndex(_ carousel: AppCarouselView, at index: Int) -> Any
    var carouselItemViewType: SwappableView.Type { get }

    func configureSwapView(view: SwappableView)
}

// MARK: - AppCarouselDelegate
@objc public protocol AppCarouselDelegate: AnyObject {
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
}
