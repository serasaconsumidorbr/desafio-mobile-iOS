//
//  CharactersListViewController+TableView.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import UIKit

// MARK: - DATA SOURCE
extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(CharactersTableViewCell.self, for: indexPath) <-< {
            $0.item = items[indexPath.row]
        }
    }
}

// MARK: - DELEGATE
extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCharacterDetails(id: items[indexPath.row].id,
                                        name: items[indexPath.row].name,
                                        description: items[indexPath.row].description,
                                        thumbnail: items[indexPath.row].thumbnail)
    }
}

// MARK: - INFINITE LOADABLE
extension CharactersListViewController: InfiniteTableLoadable {
    func loadingCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(LoadingTableViewCell.self, for: indexPath) <-< {
            $0.backgroundColor = .clear
        }
    }

    func retryCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(GenericRetryTableViewCell.self, for: indexPath)
    }

    func emptyCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(EmptyTableViewCell.self, for: indexPath)
    }
}
