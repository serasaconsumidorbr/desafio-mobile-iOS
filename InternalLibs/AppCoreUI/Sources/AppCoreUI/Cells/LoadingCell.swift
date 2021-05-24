//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors
import SnapKit


public final class LoadingCell: BaseTableViewCell {
    
    lazy var refreshControl: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicatorView.style = .large
        }
        indicatorView.color = .appBackgroundColor
        return indicatorView
    }()
    
    public override func setupUI() {
        super.setupUI()
        contentView.addSubview(refreshControl)
        refreshControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        refreshControl.startAnimating()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        refreshControl.startAnimating()
    }
    
}
