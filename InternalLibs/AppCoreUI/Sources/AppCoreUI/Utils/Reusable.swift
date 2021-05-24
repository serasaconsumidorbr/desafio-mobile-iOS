//
//  File.swift
//  
//
//  Created by Lucas Paim on 23/05/21.
//

import UIKit


public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String { NSStringFromClass(self) }
}

// MARK: - Table View convenience methods
public extension UITableView {

    /// Register an UITableViewCell to a UITableView.
    /// Be aware to use this only with viewcode type cells, this will not work properly with .xib and storyboard cells.
    ///
    func register<Cell>(_ cellType: Cell.Type) where Cell: UITableViewCell, Cell: Reusable {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func registerHeaderFooter<Cell>(_ cellType: Cell.Type) where Cell: UITableViewHeaderFooterView, Cell: Reusable {
        register(cellType, forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Dequeue an UITableViewCell to a UITableView.
    /// Be aware to use this only with viewcode type cells, this will not work properly with .xib and storyboard cells.
    ///
    func dequeue<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell, Cell: Reusable {
        // It's better to have the app crashing here. If we can't load the cell it means that we forgot to register it somewhere,
        // a regression test would catch this "problem" if the developer didn't found it yet. Worst case scenario it's better a
        // app crashing than an empty and useless list of nothing.
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
            ?? Cell(style: .default, reuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeueHeaderFooter<Cell>(_ cellType: Cell.Type) -> Cell where Cell: UITableViewHeaderFooterView, Cell: Reusable {
        return dequeueReusableHeaderFooterView(withIdentifier: cellType.reuseIdentifier) as? Cell
            ?? Cell(reuseIdentifier: cellType.reuseIdentifier)
    }
}
