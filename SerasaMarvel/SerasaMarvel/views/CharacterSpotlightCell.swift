//
//  CharacterSpotlight.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 27/06/21.
//

import UIKit

class CharacterSpotlightCell : UICollectionViewCell {
    
//    UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    
    var character: CharacterSpotlightCell? {
        didSet {
            if let name = character {
                firstChapterLabel.text = "asjdhakj sdkjashdkjashdk"
            }
        }
    }

    let secondCellId = "secondCellId"

//    let appsCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.clear
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()

    let firstChapterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.userInterfaceIdiom == .phone {
            label.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.medium)
        } else {
            label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.medium)
        }
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        return label
    }()



    override init(frame: CGRect) {
        super.init(frame: frame)

//        addSubview(appsCollectionView)
//        appsCollectionView.dataSource = self
//        appsCollectionView.delegate = self
//        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: secondCellId)
//
//        appsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
//        appsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
//        appsCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
//        appsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        addSubview(firstChapterLabel)
        firstChapterLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        firstChapterLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        firstChapterLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        if let count = appCategory?.apps?.count {
////            return count
////        }
//        return 10
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: secondCellId, for: indexPath) as! AppCell
//        cell.app = appCategory?.apps?[indexPath.item]
//        return cell
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.height, height: frame.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }



}
