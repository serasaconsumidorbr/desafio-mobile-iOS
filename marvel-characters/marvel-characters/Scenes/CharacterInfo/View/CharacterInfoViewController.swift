//
//  CharacterInfoViewController.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

class CharacterInfoViewController: UITableViewController {
    var viewModel: CharacterInfoViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    func update() {
        guard let viewModel = viewModel else {
            return
        }
        title = viewModel.selectedCharacter.name
        setHeader(with: viewModel.selectedCharacter)
    }
    
    private func render() {
        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
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

extension CharacterInfoViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel,
              let sectionItem = viewModel.getSectionAt(section) else {
            return nil
        }
        let header = CharacterInfoSectionHeaderView()
        header.section = sectionItem
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfRowInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoCell.identifier, for: indexPath) as? CharacterInfoCell,
              let viewModel = viewModel,
              let item = viewModel.getItemAt(indexPath) else {
            return UITableViewCell()
        }
        cell.setupData(with: item)
        return cell
    }
}

extension CharacterInfoViewController: CharacterInfoSectionHeaderViewDelegateProtocol {
    func didPressSection(_ section: Int) {
        viewModel?.toggleSectionAt(section)
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }
}
