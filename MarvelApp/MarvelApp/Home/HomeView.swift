//
//  HomeView.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 20/05/23.
//

import UIKit
import Lottie
import SnapKit

class HomeView: UIView {
    
    private var loadingView = AnimationView(animation: .named("ironManLoading"))
    
    private var carouselHeaderView = CarouselHeaderView()

    private lazy var charactersCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsVerticalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.register(CarouselHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collection.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "characterlCellId")
        return collection
    }()
    
    private let viewModel: HomeViewModel
    private var homeCharactersData = [HomeCharacterModel]()
    private var topFiveCharacters = [HomeCharacterModel]()
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.backgroundColor = .white
        viewModel.delegate = self
        setupLayout()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Collection View Delegate and Data Source
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeCharactersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterlCellId", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        cell.setupWith(character: homeCharactersData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 160);
    }
}

// MARK: - Home View Model Delegate
extension HomeView: HomeViewModelDelegate {
    func isFetchingFirstData(_ bool: Bool) {
        DispatchQueue.main.async {
            if !bool {
                self.loadingView.stop()
                self.loadingView.isHidden = true
                self.charactersCollectionView.isHidden = false
                self.carouselHeaderView.isHidden = false
                self.carouselHeaderView.reloadInputViews()
                self.charactersCollectionView.reloadData()
            }
        }
    }
    
    func updateCharacterList(_ characters: [HomeCharacterModel]) {
        DispatchQueue.main.async {
            self.homeCharactersData = characters
            self.charactersCollectionView.reloadData()
        }
    }
    
    func updateTopFive(_ characters: [HomeCharacterModel]) {
        DispatchQueue.main.async {
            self.topFiveCharacters = characters
            self.carouselHeaderView.setupWith(characters: characters)
        }
    }
}

// MARK: - Layout
extension HomeView {
    
    private func setupLayout() {
        setupLoadingView()
        setupTopView()
        setupCharactersTableView()
    }
    
    private func setupLoadingView() {
        self.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.loopMode = .loop
        loadingView.play()
    }
    
    private func setupTopView() {
        self.addSubview(carouselHeaderView)
        carouselHeaderView.isHidden = true
        carouselHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupCharactersTableView() {
        self.addSubview(charactersCollectionView)
        charactersCollectionView.isHidden = true
        
        charactersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(carouselHeaderView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
    }
}

