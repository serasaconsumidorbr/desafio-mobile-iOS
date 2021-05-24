//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors
import SnapKit


public final class RetryCell: BaseTableViewCell {
    
    lazy var btnRetry: AppButton = {
        let button = AppButton()
        button.setTitle("TENTAR NOVAMENTE", for: UIControl.State())
        button.isExclusiveTouch = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    public override func setupUI() {
        super.setupUI()

        contentView.addSubview(btnRetry)
        btnRetry.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.bottom.equalToSuperview().inset(16)
            make.trailing.leading.equalToSuperview().inset(32)
        }
    }
    
}
