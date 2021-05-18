//
//  LoadingTableViewCell.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import UIKit

public final class LoadingTableViewCell: DefaultTableViewCell, Reusable {

    // MARK: - View's
    lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView() <-< {
        $0.style = .medium
    }

    // MARK: - Func's
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(activityIndicator)
        activityIndicator.anchorFillSuperView()
        activityIndicator.startAnimating()
    }
}
