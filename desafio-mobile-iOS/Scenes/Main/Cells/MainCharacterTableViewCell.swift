//
//  MainCharacterTableViewCell.swift
//  Marvel
//
//  Created by andre mietti on 17/05/21.
//

import UIKit

class MainCharacterTableViewCell: UITableViewCell {

    override var reuseIdentifier: String? {
        return "MainCharacterTableViewCell"
    }

    let rootView = MainCharacterListView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tintColor = .white
        let chevronImageView = UIImageView(image: UIImage(named: "chevron_right_white"))
        accessoryView = chevronImageView
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubview(rootView)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        setupConstraints()
    }

    func configureCell(character: CharacterResponseDataModel) {
        rootView.setView(character: character)
    }

    private func setupConstraints() {
        rootView.constraint {[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]}
    }

}
