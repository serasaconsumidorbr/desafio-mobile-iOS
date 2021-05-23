//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import UIKit



extension AppCarouselView: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard let dataSource = dataSource,
            scrollView == swapScrollView else { return }

        let offsetX = scrollView.contentOffset.x
        let itemsNumber = dataSource.numberOfItems(self)

        if offsetX > scrollView.frame.size.width * 1.5 {

            let endIndex = startPageIndex + 2
            if endIndex + 1 < itemsNumber {
                // 1. Update the model. Remove (n-1)th and add (n+2)th.
                startPageIndex += 1
                // 2. Shown later. Configure frames for n ~ n+2 pages.
                layoutsScrolling()
                // 3. Adjust the view port
                scrollView.contentOffset.x -= UIScreen.main.bounds.width
            }
        }

        if offsetX < scrollView.frame.size.width * 0.5 {
            let newIndex = startPageIndex - 1
            if newIndex >= 0 {
                // 1. Update the model. Remove (n+1)th and add (n-2)th.
                startPageIndex = newIndex
                // 2. Shown later. Configure frames for n-2 ~ n pages.
                layoutsScrolling()
                // 3. Adjust the view port
                scrollView.contentOffset.x += UIScreen.main.bounds.width
            }
        }

        delegate?.scrollViewDidScroll?(scrollView)
    }

    func layoutsScrolling() {
        updateScrollViewLayout()
        viewsOnScreen.enumerated().forEach { (index: Int, container: SwappableView) in
            guard let dataSource = dataSource,
                dataSource.numberOfItems(self) > (startPageIndex + index) else {
                    container.viewRef?.isHidden = true
                    return
            }

            container.viewRef?.isHidden = false
            let item = dataSource.itemAtIndex(self, at: startPageIndex + index)
            container.presentData(data: item)

            updateContainerFrame(container: container, on: index)
        }
    }
}
