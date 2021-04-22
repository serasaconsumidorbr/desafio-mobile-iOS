//
//  EmptyTableViewCell.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class EmptyTableViewCell: DefaultTableViewCell, Reusable {

    // MARK: - Views
    lazy var wrapperView: UIView =  UIView() <-< {
        $0.backgroundColor = .lightGray
        $0.cornerRadius = 10
        $0.clipsToBounds = true
    }

    lazy var titleLabel: UILabel = UILabel() <-< {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .white
        $0.text = "Infelizmente não temos personagens no momento :("
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        contentView.backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(wrapperView)
        wrapperView.anchor(top: AnchorParameter(anchor: contentView.topAnchor, padding: 8),
                           left: AnchorParameter(anchor: contentView.leftAnchor, padding: 20),
                           right: AnchorParameter(anchor: contentView.rightAnchor, padding: 20),
                           bottom: AnchorParameter(anchor: contentView.bottomAnchor, padding: 8))

        wrapperView.addSubview(titleLabel)
        titleLabel.anchor(top: AnchorParameter(anchor: wrapperView.topAnchor, padding: 27),
                          left: AnchorParameter(anchor: wrapperView.leftAnchor, padding: 8),
                          right: AnchorParameter(anchor: wrapperView.rightAnchor, padding: 8),
                          bottom: AnchorParameter(anchor: wrapperView.bottomAnchor, padding: 27))
    }
}
