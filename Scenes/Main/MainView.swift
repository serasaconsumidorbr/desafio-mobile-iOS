//
//  MainView.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

public protocol MainViewDelegate: AnyObject {
    func didRefresh()
    func didMove(to index: Int)
    func showInstallment()
    func loadMoreData()
}

class MainView: SceneView {

    let mainScreen = UIScreen.main.bounds
    lazy var thirtyPercent: CGFloat = 0.3

    public var delegate: MainViewDelegate?
    private let containerView = configure(UIView()) {
        $0.backgroundColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let marvelCollectionView = configure(MarvelCollectionView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let marvelTableView = configure(MarvelTableView()) {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        backgroundColor = .black
        marvelTableView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(marvelCollectionView)
        containerView.addSubview(marvelTableView)
    }

    override func setupConstraints() {
        containerView.constraint {[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]}

        marvelCollectionView.constraint {[
            $0.topAnchor.constraint(equalTo: containerView.topAnchor),
            $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: thirtyPercent, constant: 1)
        ]}

        marvelTableView.constraint {[
            $0.topAnchor.constraint(equalTo: marvelCollectionView.bottomAnchor, constant: 0.0),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]}
    }

    func loadMarvelCharacters(characters: [CharacterResponseDataModel]) {
        marvelCollectionView.loadWithCharacters(characters: characters)
    }

    func loadCharactersInTableView(characters: [CharacterResponseDataModel]) {
        marvelTableView.setTableView(characters: characters)
    }

    func endRefresh() {
        marvelTableView.endRefresh()
    }
}

extension MainView: MarvelTableViewDelegate {
    func refreshTable() {
        delegate?.didRefresh()
    }

    func didTapOnCharacter(character: CharacterResponseDataModel) {

    }

    func loadMoreData() {
        delegate?.loadMoreData()
    }
}
