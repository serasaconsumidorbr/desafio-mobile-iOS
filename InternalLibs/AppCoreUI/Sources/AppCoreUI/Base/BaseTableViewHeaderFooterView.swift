//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit
import AppColors

open class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView, Reusable {

    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupUI() {
        backgroundColor = .appBackgroundColor
    }

}
