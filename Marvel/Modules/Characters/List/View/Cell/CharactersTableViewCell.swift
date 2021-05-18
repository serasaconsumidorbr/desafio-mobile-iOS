//
//  CharactersTableViewCell.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CharactersTableViewCell: DefaultTableViewCell, Reusable {

    // MARK: - View's
    lazy var imageViewIcon: ImageLoader = ImageLoader() <-< {
        $0.contentMode = .scaleAspectFit
    }

    lazy var lblName: UILabel = UILabel() <-< {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.black
        $0.text = " - "
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

    lazy var lblDescription: UILabel = UILabel() <-< {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor.gray
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

    // MARK: - Var's
    var item: CharacterList.Character? {
        didSet {
            lblName.text = item?.name
            lblDescription.text = item?.description
            imageViewIcon.loadImage(urlString: item?.thumbnail ?? "")
        }
    }

    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        selectionStyle = .none
        contentView.addSubview(imageViewIcon)
        imageViewIcon.anchor(top: AnchorParameter(anchor: contentView.topAnchor, padding: 8),
                             left: AnchorParameter(anchor: contentView.leftAnchor, padding: 8),
                             bottom: AnchorParameter(anchor: contentView.bottomAnchor, padding: 8, constraintType: .lessThanOrEqual),
                             width: 100,  height: 100)

        contentView.addSubview(lblName)
        lblName.anchor(top: AnchorParameter(anchor: contentView.topAnchor, padding: 8),
                       left: AnchorParameter(anchor: imageViewIcon.rightAnchor, padding: 8),
                       right: AnchorParameter(anchor: contentView.rightAnchor, padding: 0))

        contentView.addSubview(lblDescription)
        lblDescription.anchor(top: AnchorParameter(anchor: lblName.bottomAnchor, padding: 8),
                              left: AnchorParameter(anchor: imageViewIcon.rightAnchor, padding: 8),
                              right: AnchorParameter(anchor: contentView.rightAnchor, padding: 0),
                              bottom: AnchorParameter(anchor: contentView.bottomAnchor, padding: 8, constraintType: .lessThanOrEqual))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewIcon.image = nil
        imageViewIcon.activityIndicator.startAnimating()
    }
}
