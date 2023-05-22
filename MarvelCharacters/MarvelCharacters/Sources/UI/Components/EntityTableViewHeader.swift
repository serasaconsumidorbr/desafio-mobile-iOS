//
//  EntityTableViewHeader.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import UIKit

class EntityTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - PUBLIC PROPERTIES
    public static let identifier = "EntityTableViewHeader"
    
    // MARK: - UI
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Marvel Characters"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingMiddle
        label.numberOfLines = 2
        label.textColor = .none
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    // MARK: - INITIALIZERS
 
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupComponents()
        addViewHierarchy()
        constraintUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SETUP
    
    private func setupComponents() {
        containerStackView.backgroundColor = .none
    }
    
    private func addViewHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(title)
    }
    
    private func constraintUI() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
}
