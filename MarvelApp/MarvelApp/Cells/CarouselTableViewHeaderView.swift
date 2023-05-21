//
//  CarouselTableViewHeaderView.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 21/05/23.
//

import UIKit

class CarouselTableViewHeaderView: UITableViewHeaderFooterView {
    
    private let headerIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HeaderIcon")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 18)
       label.numberOfLines = 0
       label.textColor = .black
       label.text = "iOS Challenge"
       return label
    }()

    private lazy var carouselCollectionView: UICollectionView = {
         let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
         collection.showsHorizontalScrollIndicator = false
         collection.dataSource = self
         collection.delegate = self
         collection.backgroundColor = .clear
         collection.isPagingEnabled = true
         collection.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "carouselCellId")
         return collection
      }()

      private var pageControl: UIPageControl = {
         let pageControl = UIPageControl()
         pageControl.pageIndicatorTintColor = .gray
         pageControl.numberOfPages = 5
         pageControl.currentPageIndicatorTintColor = .white
         return pageControl
      }()
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureView()
    }
}

// MARK: - Collection View Delegate and Data Source
extension CarouselTableViewHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCellId", for: indexPath) as? CarouselCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 400);
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
      
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
      
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

// MARK: - Layout
extension CarouselTableViewHeaderView {
    
    private func setupLayout() {
        setupHeaderIconImageView()
        setupTitleLabel()
        setupCarouselCollectionView()
        setupPageControl()
    }
    
    private func setupHeaderIconImageView() {
        self.addSubview(headerIconImageView)
        
        headerIconImageView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(50)
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
    }
    
    private func setupTitleLabel() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(headerIconImageView)
            make.leading.equalTo(headerIconImageView.snp.trailing).offset(10)
        }
    }
    
    private func setupCarouselCollectionView() {
        self.addSubview(carouselCollectionView)
        
        carouselCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerIconImageView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func setupPageControl() {
        self.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            //make.top.equalTo(carouselCollectionView.snp.bottom).offset(10)
            make.centerX.equalTo(carouselCollectionView)
            make.centerY.equalTo(carouselCollectionView).offset(60)
           // make.bottom.equalToSuperview().offset(-5)
        }
    }
}

// MARK: - Helpers
extension CarouselTableViewHeaderView {
    
    private func configureView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = .init(width: frame.width, height: 400)
       // flowLayout.sectionInset = .init(top: 0, left: 60, bottom: 0, right: 60)
        flowLayout.minimumLineSpacing = 0
        carouselCollectionView.collectionViewLayout = flowLayout
    }
    
    private func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
}
