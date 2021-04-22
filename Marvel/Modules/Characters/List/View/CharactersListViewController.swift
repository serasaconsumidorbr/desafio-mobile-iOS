//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CharactersListViewController: DefaultViewController {

    // MARK: - View's
    lazy var tableView: UITableView = UITableView() <-< {
        $0.backgroundColor = .clear
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 200
        $0.tableFooterView = UIView()
        $0.register(CharactersTableViewCell.self)
        $0.register(LoadingTableViewCell.self)
        $0.register(EmptyTableViewCell.self)
        $0.register(GenericRetryTableViewCell.self)
    }

    lazy var tableViewProxy: PaginatedTableViewProxyData = PaginatedTableViewProxyData(dataSource: self,
                                                                                       delegate: self,
                                                                                       tableView: tableView) <-< {
        $0.currentState = .infiniteLoading
        $0.retryCallBack = { [weak self] in
            self?.tableViewProxy.currentState = .infiniteLoading
            self?.askForPage()
        }
        $0.infiniteScrollingCallBack = { [weak self] in
            self?.offset += 20
            self?.askForPage()
        }
    }

    // MARK: - Var's
    var interactor: CharactersListBusinessLogic?
    var router: (NSObjectProtocol & CharactersListRoutingLogic & CharactersListDataPassing)?
    var items: [CharacterList.Character] = []
    var offset: Int = 0

    // MARK: - Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        title = "Marvel Characters"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchorFillSuperView(padding: 0, inSafeArea: false)

        tableView.delegate = tableViewProxy
        tableView.dataSource = tableViewProxy
    }

    // MARK: - Appear
    override func viewDidApperFirstTime() {
        super.viewDidApperFirstTime()
        askForPage()
    }

    // MARK: - Auxiliary Func's
    func askForPage() {
        let request = CharacterList.FetchCharacters.Request(offset: offset)
        interactor?.fetchCharacters(request: request)
    }
}
