//
//  HeroListTableViewCell.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 18/04/23.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

final class HeroListTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var heroImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 33
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var heroName: UILabel = {
        let label = UILabel()
        label.textColor = .white_F8F8F8
        label.numberOfLines = 2
        label.font = UIFont.customFont(font: .regular, size: 16)
        label.isSkeletonable = true
        return label
    }()
    
    static let identifier = "heroListCell"
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods
extension HeroListTableViewCell {
    func setupData(hero: CharacterModel) {
        heroImage.loadURL(url: hero.thumbnail?.path, format: hero.thumbnail?.format)
        heroName.text = hero.name
    }
}

//MARK: - Layout
extension HeroListTableViewCell {
    private func setupView() {
        self.isSkeletonable = true
        self.layer.cornerRadius = 0
        self.backgroundColor = .white.withAlphaComponent(0.2)
        self.buildHierarchy()
    } 
    
    private func buildHierarchy() {
        heroImageContraints()
        heroNameConstraints()
    }
    
    private func heroImageContraints() {
        self.contentView.addSubview(heroImage)
        heroImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.size.equalTo(65)
        }
    }
    
    private func heroNameConstraints() {
        self.contentView.addSubview(heroName)
        heroName.snp.makeConstraints { make in
            make.centerY.equalTo(heroImage)
            make.leading.equalTo(heroImage.snp.trailing).offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
        }
    }
}
