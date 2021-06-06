//
//  CharacterInfoView.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

class CharacterInfoView: UIView {
    var viewModel: CharacterInfoViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    let tableView: UITableView
    
    override init(frame: CGRect) {
        tableView = UITableView()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        guard let viewModel = viewModel else {
            return
        }
        setHeader(with: viewModel.selectedCharacter)
    }
    
    private func setupView() {
        buildViewHierarchy()
        buildViewConstraints()
        configure()
        render()
    }
    
    private func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    private func buildViewConstraints() {
        tableView.anchor(
            top: (topAnchor, 0),
            left: (leftAnchor, 0),
            right: (rightAnchor, 0),
            bottom: (bottomAnchor, 0)
        )
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func render() {
        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(CharacterInfoCell.self, forCellReuseIdentifier: CharacterInfoCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    private func setHeader(with character: Character) {
        let header = CharacterInfoHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        header.viewModel = CharacterInfoHeaderViewModel(with: character)
        tableView.tableHeaderView = header
    }
}

extension CharacterInfoView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel,
              let sectionItem = viewModel.getSectionAt(section) else {
            return nil
        }
        let header = CharacterInfoSectionHeaderView()
        header.section = sectionItem
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoCell.identifier, for: indexPath) as? CharacterInfoCell,
              let viewModel = viewModel,
              let item = viewModel.getItemAt(indexPath) else {
            return UITableViewCell()
        }
        cell.setupData(with: item)
        return cell
    }
}

extension CharacterInfoView: CharacterInfoSectionHeaderViewDelegateProtocol {
    func didPressSection(_ section: Int) {
        viewModel?.toggleSectionAt(section)
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }
    
    
}
