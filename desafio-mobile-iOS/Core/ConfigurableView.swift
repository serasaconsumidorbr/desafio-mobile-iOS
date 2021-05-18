//
//  ConfigurableView.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

protocol ConfigurableView: UIView {
    func setupView ()
    func buildViewHierarchy ()
    func setupConstraints ()
}

extension ConfigurableView {
    func setupView () {
        translatesAutoresizingMaskIntoConstraints = false
        buildViewHierarchy()
        setupConstraints()
    }
}

