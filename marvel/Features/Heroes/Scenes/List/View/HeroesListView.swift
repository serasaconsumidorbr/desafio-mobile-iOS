//
//  HeroesListView.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

protocol HeroesListViewDelegate: UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching{
    
}

class HeroesListView: UIView {
    
    var delegate: HeroesListViewDelegate? {
        didSet {
            guard let delegate = delegate else {
                return
            }
            carouselCollectionView.dataSource = delegate
            tableView.delegate = delegate
            tableView.dataSource = delegate
            tableView.prefetchDataSource = delegate
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubViews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var carouselCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.bounces = true
        collectionView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        collectionView.register(HeroesCarouselCell.self, forCellWithReuseIdentifier: HeroesCarouselCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    public lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        ])
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.backgroundColor = .white
        return stackView
    }()
    
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(HeroesTableViewCell.self, forCellReuseIdentifier: HeroesTableViewCell.identifier)
        tableView.scrollIndicatorInsets = .zero
        tableView.sectionHeaderTopPadding = 0
        tableView.estimatedSectionHeaderHeight = 0.0
        tableView.sectionHeaderHeight = 0.0
        tableView.estimatedSectionFooterHeight = 0.0
        tableView.sectionFooterHeight = 0.0
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.bounces = false
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    func addSubViews() {
        clipsToBounds = true
        
        addSubview(contentView)
        contentView.addSubview(carouselCollectionView)
        contentView.addSubview(stackView)
        contentView.addSubview(tableView)

        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            carouselCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carouselCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            carouselCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: 200),
            stackView.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor)
        ])
        updateIndex(selectedIndex: -1)
    }
    
    func updateIndex(selectedIndex: Int) {
        stackView.removeAllArrangedSubviews()
        var constraints = [
            stackView.heightAnchor.constraint(equalToConstant: 10)
        ]
        for index in 0..<5 {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(contentsOf: [
                view.widthAnchor.constraint(equalToConstant: 6),
                view.heightAnchor.constraint(equalToConstant: 6)
            ])
            view.layer.cornerRadius = 3
            if (selectedIndex == -1 && index == 0) || selectedIndex == index {
                view.backgroundColor = .black
            } else {
                view.backgroundColor = .gray
            }
            stackView.addArrangedSubview(view)
            constraints.append(stackView.widthAnchor.constraint(equalToConstant: 50))
        }
        NSLayoutConstraint.activate(constraints)
        
    }
    
}



extension HeroesListView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        return CGSize(width: width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }

}

extension HeroesListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        updateIndex(selectedIndex: indexPath.row)
    }
}


