//
//  CarouselCell.swift
//  Marvel Characters
//
//  Created by Leonardo Bandeira on 30/01/23.
//

import SDWebImage
import SkeletonView
import UIKit

fileprivate extension CarouselCell.Layout {
    enum Size {
        static let cardSize: CGSize = CGSize(width: 170, height: 290)
        static let itemHeight: CGFloat = cardSize.height + 32
    }
    
    enum Spacing {
        static let minimumLineSpacing: CGFloat = 16
    }
}

final class CarouselCell: UITableViewCell {
    // MARK: - Propery(ies).
    enum Layout {}
    static let identifier = "\(CarouselCell.self)"
    
    private var characters = [Character]() {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Component(s).
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Layout.Size.cardSize
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = Layout.Spacing.minimumLineSpacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: Layout.Spacing.minimumLineSpacing,
            bottom: 0,
            right: Layout.Spacing.minimumLineSpacing
        )
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.dataSource = self
        collectionView.isSkeletonable = true
        collectionView.register(CharacterCard.self, forCellWithReuseIdentifier: CharacterCard.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Initialization(s).
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    func configure(with characters: [Character]) -> Self {
        self.characters = characters
        return self
    }
    
    // MARK: - Setup(s).
    private func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureView()
    }
}

// MARK: - View Configuration.
private extension CarouselCell {
    private func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Layout.Size.itemHeight)
        ])
    }
    
    private func configureView() {
        isSkeletonable = true
        contentView.backgroundColor = .white
        selectionStyle = .none
    }
}

// MARK: - CollectionView DataSource.
extension CarouselCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterCard.identifier,
                for: indexPath
              ) as? CharacterCard else { return UICollectionViewCell() }
        return cell.configure(with: characters[indexPath.item])
    }
}

// MARK: - SkeletonView DataSource.
extension CarouselCell: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        CharacterCard.identifier
    }
}
