//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import Foundation
import UIKit
import SnapKit

public final class AppCarouselView: UIViewController {

    // MARK: Public proprieties
    public weak var dataSource: AppCarouselDataSource? {
        didSet {
            reloadData()
        }
    }
    public weak var delegate: AppCarouselDelegate?

    // MARK: Internal Views

    lazy var swapScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    var viewsOnScreen: [SwappableView] = []
    var startPageIndex: Int = 0

    var currentIndex: Int {
        let currentPage: Int = Int(swapScrollView.contentOffset.x / UIScreen.main.bounds.width)
        return startPageIndex + currentPage
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollViewLayout()
    }

    // MARK: Views Initialization
    fileprivate func commonInit() {
        view.addSubview(swapScrollView)
        swapScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    public func moveToIndex(index: Int) {
        guard let dataSource = dataSource,
            index < dataSource.numberOfItems(self) else { return }

        let numberOfItens = dataSource.numberOfItems(self)
        let offsetValue: CGFloat

        switch max(index, 0) {
        case 0:
            startPageIndex = index
            offsetValue = 0
        case numberOfItens - 1:
            let offset = viewsOnScreen.count - 1
            startPageIndex = max(0, index - offset)
            offsetValue = CGFloat(offset)
        default:
            startPageIndex = max(0, index - 1)
            offsetValue = 1
        }

        swapScrollView.contentOffset.x = min(offsetValue * UIScreen.main.bounds.width,
                                             swapScrollView.contentSize.width)
        self.layoutsScrolling()
    }

    public func presentByBroadcast(data: Any) {
        DispatchQueue.global().async { [weak self] in
            sleep(1)
            DispatchQueue.main.async { [weak self] in
                self?.viewsOnScreen.forEach {
                    $0.presentByBroadcast(data: data)
                }
            }
        }
    }
}
