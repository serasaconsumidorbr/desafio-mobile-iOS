//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors
import SnapKit


public final class EmptyCell: BaseTableViewCell {
    
    lazy var disclaimerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont(name: "marvel", size: 32)!
        label.text = "Não encontramos nenhum personagem 😢"
        return label
    }()
    
    public override func setupUI() {
        super.setupUI()
        contentView.addSubview(disclaimerLabel)
        disclaimerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview().inset(16)
        }
    }

}
