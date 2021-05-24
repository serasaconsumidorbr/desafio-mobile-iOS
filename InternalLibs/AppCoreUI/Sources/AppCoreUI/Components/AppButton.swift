//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors


public class AppButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupUI()
    }
    
    public convenience init() {
        self.init(frame: .zero)
        setupUI()
    }
    
    open func setupUI() {
        self.backgroundColor = .secondaryBackgroundColor
        self.titleLabel?.font = UIFont(name: "marvel", size: 24)!
        self.titleLabel?.textColor = .textColor
    }
    
}
