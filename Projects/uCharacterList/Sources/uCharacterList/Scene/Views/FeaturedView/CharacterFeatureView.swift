//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import Carousel
import AppCoreUI
import AppCore
import AppColors
import SDWebImage


protocol CharacterFeatureViewDelegate: AnyObject {
    func openCharacterDetail(id: Int)
}

final class CharacterFeatureView: BaseCustomView, SwappableView {
    var viewRef: UIView? { self }
    var presentingId: Int?
    
    weak var delegate: CharacterFeatureViewDelegate?
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGesture)
        return image
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.numberOfTouchesRequired = 1
        tap.addTarget(self, action: #selector(openDetail))
        return tap
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "marvel", size: 36)
        label.backgroundColor = .secondaryBackgroundColor
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .textColor
        return label
    }()
    
    @objc func openDetail() {
        guard let id = presentingId else { return }
        delegate?.openCharacterDetail(id: id)
    }
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(backgroundImage)
        addSubview(nameLabel)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func presentData(data: Any) {
        guard let character = data as? CharacterList.CharacterModel else { return }
        presentingId = character.id
        backgroundImage.sd_cancelCurrentImageLoad()
        backgroundImage.sd_setImage(with: URL(string: character.photo), placeholderImage: UIImage(named: "placeholder"))
        nameLabel.text = character.name.uppercased()
    }
    
    func presentByBroadcast(data: Any) { }
}
