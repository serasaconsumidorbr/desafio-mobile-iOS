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
    private var isShowingCharacterTitle: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    func update() {
        guard let viewModel = viewModel else {
            return
        }
        setHeader(with: viewModel.selectedCharacter)
    }
    
    private func render() {
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
    
    private func chageTitle(to title: String?){
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.3
        fadeTextAnimation.type = .fade
            
        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
        navigationItem.title = title
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel else { return }
        if tableView.contentOffset.y > 180 && !isShowingCharacterTitle {
            isShowingCharacterTitle = true
            chageTitle(to: viewModel.selectedCharacter.name)
            
        } else if tableView.contentOffset.y < 180 && isShowingCharacterTitle {
            isShowingCharacterTitle = false
            chageTitle(to: String())
            
        }
    }
}

extension CharacterInfoViewController: CharacterInfoSectionHeaderViewDelegateProtocol {
    func didPressSection(_ section: Int) {
        viewModel?.toggleSectionAt(section)
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }
}
