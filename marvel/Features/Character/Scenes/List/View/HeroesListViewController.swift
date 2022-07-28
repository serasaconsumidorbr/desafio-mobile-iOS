//
//  HeroesListViewController.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

protocol HeroesListViewModelProtocol: AnyObject {
    func buildViewModel() -> HeroesListView.Model?
    func onViewDidAppear()
}

class HeroesListViewController: ViewController {
    
    private let viewModel: HeroesListViewModelProtocol
    
    private lazy var heroesListView: HeroesListView = {
        let view = HeroesListView(model: viewModel.buildViewModel())
    }()
    
    init(
        with viewModel: HeroesListViewModelProtocol
    ) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = heroesListView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }
    
}

extension HeroesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension HeroesListViewController : UITableViewDelegate {
    
}
