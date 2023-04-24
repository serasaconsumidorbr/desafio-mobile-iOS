//
//  CarrousselCollectionViewCell.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 18/04/23.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

final class CarrousselCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var imageCarroussel: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 35
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    static let identifier = "carrousselCell"
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods
extension CarrousselCollectionViewCell {
    func setupImage(hero: CharacterModel) {
        self.imageCarroussel.loadURL(url: hero.thumbnail?.path, format: hero.thumbnail?.format)
    }
}

//MARK: - Layout
extension CarrousselCollectionViewCell {
    private func setupView() {
        self.isSkeletonable = true
        self.layer.cornerRadius = 35
        contentView.isSkeletonable = true
        self.buildHierarchy()
    }
    
    private func buildHierarchy() {
        contraintsImageCarroussel()
    }
    
    private func contraintsImageCarroussel() {
        self.contentView.addSubview(imageCarroussel)
        imageCarroussel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
