//
//  MarvelTableView.swift
//  Marvel
//
//  Created by andre mietti on 17/05/21.
//

import UIKit

protocol MarvelTableViewDelegate: AnyObject {
    func refreshTable()
    func loadMoreData()
    func didTapOnCharacter(character: CharacterResponseDataModel)
}

class MarvelTableView: SceneView {

    private let cellIdentifier = MainCharacterTableViewCell().reuseIdentifier.defaultValue
    private var characters = [CharacterResponseDataModel]()
    var delegate: MarvelTableViewDelegate?
    var isLoading = false

    private var refreshControl = configure(UIRefreshControl()) {
        $0.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        $0.tintColor = .white
    }

    private lazy var tableView = configure(UITableView()) {
        $0.register(MainCharacterTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset = .zero
        $0.frame = self.frame
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100.0
        $0.tableFooterView = UIView()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.addSubview(refreshControl)
    }

    @objc func refresh(_ sender: AnyObject) {
        delegate?.refreshTable()
    }

    func endRefresh() {
        refreshControl.endRefreshing()
    }
    override func buildViewHierarchy() {
        addSubview(tableView)
    }

    override func setupConstraints() {
        tableView.constraint {[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]}
    }

    func setTableView(characters: [CharacterResponseDataModel]) {
        isLoading = false
        self.characters = characters
        tableView.reloadData()
    }

}

extension MarvelTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapOnCharacter(character: characters[indexPath.row])
    }
}

extension MarvelTableView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MainCharacterTableViewCell else {
            return MainCharacterTableViewCell()
        }
        cell.configureCell(character: characters[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == characters.count - 1 && !isLoading {
//            isLoading = true
//            delegate?.loadMoreData()
//        }
//    }
}

extension MarvelTableView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            isLoading = true
            delegate?.loadMoreData()
        }
    }

}
