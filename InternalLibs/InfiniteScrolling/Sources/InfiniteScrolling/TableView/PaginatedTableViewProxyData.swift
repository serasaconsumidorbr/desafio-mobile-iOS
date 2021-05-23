//
//  File.swift
//
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit

@objc public protocol InfiniteTableLoadable {
    @objc optional func loadingCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    @objc optional func retryCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    @objc optional func emptyCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    @objc optional func willChange(
        from old: PaginatedTableViewProxyData.States,
        to new: PaginatedTableViewProxyData.States
    )

    @objc optional func targetStatusCellSection(tableView: UITableView) -> Int
}

final public class PaginatedTableViewProxyData: NSObject, UITableViewDataSource, UITableViewDelegate {

    typealias PaginatedDataSouce = UITableViewDataSource & InfiniteTableLoadable
    
    @objc public enum States : Int {
        case none,
        infiniteLoading,
        retryError,
        pullLoading,
        empty
    }
    
    var currentState: States = .none {
        didSet {
            if currentState == .none {
                hideLastCell()
            } else {
                displayLastCell()
            }
        }
        willSet {
            dataSource?.willChange?(from: currentState, to: newValue)
        }
    }
    
    var haveNextPage: Bool = false
    var infiniteScrollingCallBack: (() -> Void)?
    var retryCallBack: (() -> Void)?
    
    internal var isShowingLastCell = false
    internal weak var dataSource: PaginatedDataSouce?
    internal weak var delegate: UITableViewDelegate?
    internal weak var tableView: UITableView?
    internal weak var scrollView: UIScrollView?
    
    init(dataSource: PaginatedDataSouce, delegate: UITableViewDelegate, tableView: UITableView,
         scrollView: UIScrollView? = nil) {
        super.init()
        self.dataSource = dataSource
        self.delegate = delegate
        self.tableView = tableView
        self.scrollView = scrollView ?? tableView
        self.scrollView?.delegate = self
    }

    func isStatusCell(at indexPath: IndexPath) -> Bool {
        guard let tableView = tableView else { return false }

        let targetSection: Int
        if let overridenSection = dataSource?.targetStatusCellSection?(tableView: tableView) {
            targetSection = overridenSection
        } else {
            targetSection = max((dataSource?.numberOfSections?(in: tableView) ?? 1) - 1, 0)
        }

        let regularCellsCount = dataSource?.tableView(tableView, numberOfRowsInSection: targetSection)
        return regularCellsCount == indexPath.row && indexPath.section == targetSection
    }
    
    fileprivate func displayLastCell() {
        guard let tableViewRef = self.tableView else { return }
        isShowingLastCell = true
        tableViewRef.reloadData()
    }
    
    fileprivate func hideLastCell() {
        guard let tableViewRef = self.tableView else { return }
        isShowingLastCell = false
        tableViewRef.reloadData()
    }

}

