//
//  CharactersListHeaderView.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 06/06/21.
//

import UIKit

class CharactersListHeaderView: UIView {
    var viewModel: CharactersListViewModelProtocol? {
        didSet {
            update()
        }
    }
    weak var delegate: CharactersListViewDelegateProtocol?
    
    let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 200)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        collectionView.reloadData()
    }
    
    private func setupView() {
        buildViewHierarchy()
        buildViewConstraints()
        configure()
        render()
    }
    
    private func buildViewHierarchy() {
        addSubview(collectionView)
    }
    
    private func buildViewConstraints() {
        collectionView.anchor(
            top: (topAnchor, 0),
            left: (leftAnchor, 0),
            right: (rightAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
    }
    
    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharactersListHeaderCell.self, forCellWithReuseIdentifier: CharactersListHeaderCell.identifier)
    }
    
    private func render() {
        backgroundColor = .black
        
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension CharactersListHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfFirstsCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersListHeaderCell.identifier, for: indexPath) as? CharactersListHeaderCell, let viewModel = viewModel,
              let character = viewModel.getFirstsCharacterAt(indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.setupData(with: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let character = viewModel.getFirstsCharacterAt(indexPath.row) else {
            return
        }
        delegate?.didSelectCharacter(character)
    }
}
