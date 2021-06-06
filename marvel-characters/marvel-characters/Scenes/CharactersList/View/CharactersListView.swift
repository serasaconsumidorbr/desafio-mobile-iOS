//
//  CharactersListView.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

protocol CharactersListViewDelegateProtocol: AnyObject {
    func didSelectCharacter(_ character: Character)
    func didSelectFavoriteCharacter(_ favoriteCharacter: FavoriteCharacter)
}

class CharactersListView: UIView {
    var viewModel: CharactersListViewModelProtocol? {
        didSet {
            update()
        }
    }
    weak var delegate: CharactersListViewDelegateProtocol?
    
    let tableView: UITableView
    
    override init(frame: CGRect) {
        tableView = UITableView()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
//        guard let viewModel = viewModel else {
//            return
//        }
//        viewModel.getCharactersList { [weak self] in
//            self?.tableView.reloadData()
//        }
        setHeader()
    }
    
    private func setupView() {
        buildViewHierarchy()
        buildViewConstraints()
        configure()
        render()
    }
    
    private func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    private func buildViewConstraints() {
        tableView.anchor(
            top: (topAnchor, 0),
            left: (leftAnchor, 0),
            right: (rightAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func render() {
        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = 100
        tableView.register(CharactersListCell.self, forCellReuseIdentifier: CharactersListCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func setHeader() {
        let header = CharactersListHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        header.viewModel = viewModel
        header.delegate = delegate
        tableView.tableHeaderView = header
    }
}

extension CharactersListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfCharacters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListCell.identifier, for: indexPath) as? CharactersListCell,
              let viewModel = viewModel,
              let character = viewModel.getCharacterAt(indexPath.row) else {
            return UITableViewCell()
        }
        cell.setupData(with: character)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let character = viewModel.getCharacterAt(indexPath.row) else {
            return
        }
        delegate?.didSelectCharacter(character)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
