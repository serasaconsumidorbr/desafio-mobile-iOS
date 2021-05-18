//
//  MainCharacterCell.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

class MainCharacterCell: UICollectionViewCell {

    override var reuseIdentifier: String? {
        return "MainCharacterCell"
    }
    
    let rootView = MainCharacterView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
        backgroundColor = .orange
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(rootView)
    }

    func configureCell(character: CharacterResponseDataModel?) {
        rootView.loadView(character: character)
    }

    private func setupConstraints() {
        rootView.constraint {[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.leftAnchor.constraint(equalTo: self.leftAnchor),
            $0.rightAnchor.constraint(equalTo: self.rightAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]}
    }

}
