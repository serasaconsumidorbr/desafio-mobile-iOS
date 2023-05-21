//
//  HomeView.swift
//  MarvelApp
//
//  Created by Rossana Rocha on 20/05/23.
//

import UIKit

class HomeView: UIView {
    
    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(CarouselTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: "carouselHeaderView")
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterTableViewCell")
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .null)
        self.backgroundColor = .systemGray4
        setupLayout()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Table View Delegate and Data Source
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterTableViewCell", for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "carouselHeaderView") as? CarouselTableViewHeaderView else { return nil }
        
        return headerView
    }
}


// MARK: - Layout
extension HomeView {
    
    private func setupLayout() {
        setupCharactersTableView()
    }
    
    private func setupCharactersTableView() {
        self.addSubview(charactersTableView)
        
        charactersTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
}

