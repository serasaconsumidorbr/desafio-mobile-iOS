//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import UIKit

extension AppCarouselView {
    public func reloadData() {

        initializeViews()
        view.layoutSubviews()

        viewsOnScreen.enumerated().forEach { (index: Int, container: SwappableView) in
            if let view = container.viewRef {

                if let subViewController = container as? UIViewController {
                    addChild(subViewController)
                    subViewController.didMove(toParent: self)
                }

                swapScrollView.addSubview(view)
                updateContainerFrame(container: container, on: index)
            }

            dataSource?.configureSwapView(view: container)
        }

        updateScrollViewLayout()
        layoutsScrolling()
    }

    func updateContainerFrame(container: SwappableView, on index: Int) {
        container.viewRef?.frame = CGRect(x: CGFloat(index) * UIScreen.main.bounds.width, y: 0,
                            width: UIScreen.main.bounds.width,
                            height: swapScrollView.frame.height)

    }

    func removePreviousViewsIfNeeded() {
        viewsOnScreen.forEach {
            $0.viewRef?.removeFromSuperview()
            if let subViewController = $0 as? UIViewController {
                subViewController.removeFromParent()
                subViewController.didMove(toParent: nil)
            }
        }
        viewsOnScreen.removeAll()
    }

    func initializeViews() {
        removePreviousViewsIfNeeded()
        guard let dataSource = dataSource else { return }
        let numberOfScreensOnSwap = min(3, dataSource.numberOfItems(self))
        for _ in 0..<numberOfScreensOnSwap {
            viewsOnScreen.append(dataSource.carouselItemViewType.init())
        }
    }

    func updateScrollViewLayout() {
        let scrollViewWidth = UIScreen.main.bounds.width
        let widthFactor: CGFloat = CGFloat(viewsOnScreen.count)
        swapScrollView.contentSize = CGSize(width: scrollViewWidth * widthFactor,
                                        height: swapScrollView.frame.size.height)
    }

}
