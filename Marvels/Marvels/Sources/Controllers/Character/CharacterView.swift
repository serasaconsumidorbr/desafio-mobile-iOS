//
//  CharacterView.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 23/05/2022.
//

import Foundation

import UIKit

class CharacterView: UIView {
    // MARK: - Closures
    
    // MARK: - Constants
    
    // MARK: - Properts
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CharacterCarouselViewCell.self, forCellWithReuseIdentifier: CharacterCarouselViewCell.identifier)
        
        collectionView.backgroundColor = .systemBlue
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    
    
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setElementsVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setElementsVisual() {
        setCollectionView()
    }
    
    private func setCollectionView() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension CharacterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCarouselViewCell.identifier, for: indexPath) as? CharacterCarouselViewCell else {
            fatalError()
        }
        
        return cell
    }
}

extension CharacterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.frame.size.width/3
        return CGSize(width: width, height: width*1.5)
    }
}
