//
//  CharacterListViewController.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import AppCore
import AppCoreUI
import AppColors
import SnapKit
import InfiniteScrolling


final class CharacterListViewController: BaseViewController {

    // Var's
    var interactor: CharacterListBusinessLogic?
    var router: (NSObjectProtocol & CharacterListRoutingLogic & CharacterListDataPassing)?

    lazy var searchDebouncer: Debouncer = {
        let debouncer = Debouncer(timeInterval: 1)
        debouncer.handler = { [weak self] in
            self?.pullToRefresh()
        }
        return debouncer
    }()
    
    lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.delegate = self
        return search
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        table.register(LoadingCell.self)
        table.register(EmptyCell.self)
        table.register(RetryCell.self)
        table.register(CharacterCell.self)
        table.separatorStyle = .none
        return table
    }()
    
    lazy var refreshControl: UIRefreshControl = RefreshControlBuilder.build()

    var proxyDelegate: PaginatedTableViewProxyData?
    
    var elements: [CharacterList.CharacterModel] = []
    var featuredItems: [CharacterList.CharacterModel] = []

    // Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        title = "PERSONAGENS"
        
        proxyDelegate = .init(dataSource: self, delegate: self, tableView: tableView)
        configureProxyDelegate()
        
        startLoading()
        interactor?.fetchCharacterPage(request: CharacterList.CharacterPage.Request(offset: 0, search: nil))
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // Appear

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureProxyDelegate() {
        proxyDelegate?.haveNextPage = true
        proxyDelegate?.addPullToRefresh(refreshControl: refreshControl)
        proxyDelegate?.infiniteScrollingCallBack = { [weak self] in
            self?.loadPage()
        }
        proxyDelegate?.retryCallBack = { [weak self] in
            self?.loadPage()
        }
    }
    
    func loadPage() {
        let offset = featuredItems.count + elements.count
        self.interactor?.fetchCharacterPage(request: .init(offset: offset, search: self.searchController.searchBar.text))
    }

    func searchUpdate() {
        emptyDataAndLoadAgain()
    }
    
    func emptyDataAndLoadAgain() {
        elements = []
        featuredItems = []
        startLoading()
        interactor?.fetchCharacterPage(request: .init(offset: 0, search: searchController.searchBar.text))
        proxyDelegate?.currentState = .infiniteLoading
    }
}
