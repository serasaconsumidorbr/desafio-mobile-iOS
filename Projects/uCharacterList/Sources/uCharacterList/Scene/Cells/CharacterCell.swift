//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors
import AppCoreUI
import SnapKit
import SDWebImage


final class CharacterCell: BaseTableViewCell {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    lazy var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()
    
    lazy var contrastColor: UIView = {
        let view = UIView()
        view.isAccessibilityElement = false
        view.backgroundColor = .contrastColor
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColorInContrast
        label.font = UIFont(name: "marvel", size: 24)!
        label.numberOfLines = 0
        return label
    }()
    
    lazy var photoBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .contrastColor
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.appBackgroundColor?.cgColor
        return view
    }()
    
    override func setupUI() {
        super.setupUI()
        
        contentView.clipsToBounds = true
        
        contentView.addSubview(backgroundImage)
        contentView.addSubview(contrastColor)
        contentView.addSubview(photoBorder)
        photoBorder.addSubview(photoImage)
        contrastColor.addSubview(nameLabel)

        backgroundImage.setContentHuggingPriority(.defaultLow, for: .vertical)
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contrastColor.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.trailing.leading.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(80)
        }
        
        photoBorder.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalTo(130)
            make.leading.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
        }
        
        photoImage.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoBorder.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(32)
            make.top.equalTo(contrastColor.snp.top).inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.sd_cancelCurrentImageLoad()
        photoImage.sd_cancelCurrentImageLoad()
    }
    
    func populateView(character: CharacterList.CharacterModel) {
        nameLabel.text = character.name.uppercased()
        backgroundImage.sd_setImage(with: URL(string: character.photo), placeholderImage: UIImage(named: "placeholder"), options: .progressiveLoad)
        photoImage.sd_setImage(with: URL(string: character.photo), placeholderImage: UIImage(named: "placeholder"), options: .progressiveLoad)
    }
    
}
