//
//  File.swift
//
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit


extension PaginatedTableViewProxyData {
    public func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = dataSource?.numberOfSections?(in: tableView) ?? 1
        return max(1, numberOfSections)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isTargetSection: Bool
        if let overridenSection = dataSource?.targetStatusCellSection?(tableView: tableView) {
            isTargetSection = overridenSection == section
        } else {
            isTargetSection = numberOfSections(in: tableView) - 1 == section
        }

        let needAddExtraCell = isTargetSection && (currentState != .none)
        return (dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0) + (needAddExtraCell ? 1 : 0)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = self.dataSource else { return UITableViewCell() }
        if isStatusCell(at: indexPath) {
            switch currentState {
            case .infiniteLoading:
                return dataSource.loadingCell!(tableView: tableView, indexPath: indexPath)
            case .retryError:
                return dataSource.retryCell!(tableView: tableView, indexPath: indexPath)
            case .empty:
                return dataSource.emptyCell!(tableView: tableView, indexPath: indexPath)
            case .none, .pullLoading:
                return UITableViewCell()
            }
        }
        
        return dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    
}
