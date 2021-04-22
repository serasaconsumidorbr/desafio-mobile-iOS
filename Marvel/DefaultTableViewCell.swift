//
//  DefaultTableViewCell.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import UIKit

open class DefaultTableViewCell: UITableViewCell {
    // MARK: - Init's
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    func setupUI() { }
}
