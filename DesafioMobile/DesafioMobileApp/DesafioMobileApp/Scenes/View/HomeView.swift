//
//  HomeView.swift
//  DesafioMobileApp
//
//  Created by Bárbara Tiefensee on 31/01/23.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView
import CoreData

final class HomeView: UIView {
    
    //MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var highlightedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.customFont(font: .bold, size: 28)
        label.text = "DESTAQUES"
        return label
    }()

    private lazy var carroussel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isSkeletonable = true
        collectionView.register(CarrousselCollectionViewCell.self, forCellWithReuseIdentifier: CarrousselCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var herosLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.customFont(font: .bold, size: 28)
        label.text = "HEROES"
        return label
    }()
    
    private lazy var heroList: UITableView = {
        let tableView = UITableView()
        tableView.isSkeletonable = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 23
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.register(HeroListTableViewCell.self, forCellReuseIdentifier: HeroListTableViewCell.identifier)
        return tableView
    }()
    
    private let viewModel: HomeViewModelProtocol
    var isLoading = false
    
    //MARK: - Init
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setupView()
        self.buildScene()
        self.buildHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods
extension HomeView {
    func uptadeView() {
        self.carroussel.reloadData()
        self.heroList.reloadData()
        self.heroList.hideSkeleton(transition: .crossDissolve(0.25))
        self.carroussel.hideSkeleton(transition: .crossDissolve(0.35))
    }
}

//MARK: - Protocol CollectionView
extension HomeView: UICollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hero = viewModel.data.carrousselInformation else { return 1 }
        return hero.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarrousselCollectionViewCell.identifier, for: indexPath) as? CarrousselCollectionViewCell else { return UICollectionViewCell() }
        if viewModel.isLoading {
            let gradient = SkeletonGradient(baseColor: UIColor.silver)
            cell.showAnimatedGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.25))
            return cell
        } else {
            guard let hero = viewModel.data.carrousselInformation else { return UICollectionViewCell() }
            cell.setupImage(hero: hero[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 90, height: collectionView.frame.height - 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 15.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return CarrousselCollectionViewCell.identifier
    }
}

//MARK: - Protocol TableView
extension HomeView: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hero = viewModel.data.heroListInformation else { return 1 }
        return hero.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeroListTableViewCell.identifier, for: indexPath) as? HeroListTableViewCell else { return UITableViewCell() }
        
        if viewModel.isLoading {
            let gradient = SkeletonGradient(baseColor: UIColor.silver)
            cell.showAnimatedGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.25))
            cell.layer.cornerRadius = 23
            return cell
        } else {
            guard let hero = viewModel.data.heroListInformation else { return UITableViewCell() }
            cell.setupData(hero: hero[indexPath.item])
            cell.layer.cornerRadius = 0
            return cell
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HeroListTableViewCell.identifier
    }
}

//MARK: - Layout
extension HomeView {
    private func setupView() {
        self.backgroundColor = .black_151514
    }
    
    private func buildHierarchy() {
        self.scrollViewContraints()
        self.highlightedLabelConstraints()
        self.carrousselConstraints()
        self.herosLabelContraints()
        self.heroListConstraints()
    }
    
    private func buildScene() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(highlightedLabel)
        contentView.addSubview(carroussel)
        contentView.addSubview(herosLabel)
        contentView.addSubview(heroList)
    }
    
    private func scrollViewContraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(contentView)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func highlightedLabelConstraints() {
        highlightedLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func carrousselConstraints() {
        carroussel.snp.makeConstraints { make in
            make.top.equalTo(highlightedLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalToSuperview()
        }
    }
    
    private func herosLabelContraints() {
        herosLabel.snp.makeConstraints { make in
            make.top.equalTo(carroussel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func heroListConstraints() {
        heroList.snp.makeConstraints { make in
            make.top.equalTo(herosLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottomMargin.equalToSuperview().offset(-15)
        }
    }
}
