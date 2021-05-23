//
//  CharacterListViewController.swift
//  App
//
//  Created by Lucas Paim on 23/05/21.
//  Copyright (c) 2021 com.example.marvel. All rights reserved.
//

import UIKit
import AppCoreUI
import AppColors
import SnapKit


final class CharacterListViewController: BaseViewController {

    // Var's
    var interactor: CharacterListBusinessLogic?
    var router: (NSObjectProtocol & CharacterListRoutingLogic & CharacterListDataPassing)?

    lazy var searchController = UISearchController()
    
    lazy var tableView = UITableView()
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .appBackgroundColor
        return refresh
    }()
    
    var elements: [CharacterList.CharacterModel] = []

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

}
