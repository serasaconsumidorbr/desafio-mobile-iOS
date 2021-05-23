//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit


open class BaseCustomView: UIView {
    
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
    
    func setupUI() { }
    
}
