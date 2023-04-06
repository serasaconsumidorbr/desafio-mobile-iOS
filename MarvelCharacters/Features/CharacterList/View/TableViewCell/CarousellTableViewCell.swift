//
//  CarousellTableViewCell.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 05/04/23.
//

import Foundation
import UIKit

class CarousellTableViewCell: UITableViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CarousellItemCollectionViewCell.self, forCellWithReuseIdentifier: "CarousellItemCollectionViewCell")
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundStyle = .prominent
        control.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
        return control
    }()
    
    var characters: [Character] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
    }
    
    func configureViews() {
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        
        contentView.addConstraints([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 14),
            pageControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            pageControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }
    
    func updateDataSource(with characters: [Character]) {
        self.characters = characters
        pageControl.numberOfPages = characters.count
        collectionView.reloadData()
    }
    
    @objc func pageChanged(_ sender: UIPageControl) {
        collectionView.scrollToItem(
            at: IndexPath(row: sender.currentPage, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
}

extension CarousellTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarousellItemCollectionViewCell", for: indexPath) as? CarousellItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.fill(with: characters[indexPath.row])
        
        return cell
    }
}

extension CarousellTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
