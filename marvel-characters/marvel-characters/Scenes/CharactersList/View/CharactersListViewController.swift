//
//  CharactersListViewController.swift
//  marvel-characters
//
//  Created by Paulo Atavila on 05/06/21.
//

import UIKit

protocol CharactersListViewDelegateProtocol: AnyObject {
    func didSelectCharacter(_ character: Character)
}

class CharactersListViewController: UITableViewController {
    var viewModel: CharactersListViewModelProtocol?
    var loader = UIActivityIndicatorView()
    
    init(viewModel: CharactersListViewModelProtocol = CharactersListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setInitialLoader()
        setupNavigation()
        update()
    }

    func update() {
        guard let viewModel = viewModel else {
            return
        }
        createAnnouncement(with: "Loading characters list")
        viewModel.getCharactersList { [weak self] in
            self?.loader.stopAnimating()
            
            if viewModel.lastRequestSuccess {
                self?.tableView.reloadData()
                if self?.tableView.tableHeaderView == nil {
                    self?.setHeader()
                }
                self?.setupTableFooter(isLoading: false)
            } else {
                self?.presentWarningAlert(title: "Error to handle with your action", message: "", buttonTitle: "Try again", action: { _ in
                    self?.loader.startAnimating()
                    self?.update()
                })
            }
        }
        
    }
    
    private func setupNavigation() {
        title = "Marvel Characters"
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationBar.barStyle = .black
        let backItem = UIBarButtonItem()
        backItem.title = String()
        self.navigationItem.backBarButtonItem = backItem
    }
    
    private func setUpTableView() {
        tableView.backgroundColor = .black
        tableView.rowHeight = 100
        tableView.register(CharactersListCell.self, forCellReuseIdentifier: CharactersListCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func setInitialLoader() {
        view.addSubview(loader)
        loader.color = .white
        loader.style = .large
        loader.hidesWhenStopped = true
        loader.startAnimating()
        
        loader.anchor(
            centerX: (view.centerXAnchor, 0),
            centerY: (view.centerYAnchor, 0)
        )
    }
    
    private func setHeader() {
        let header = CharactersListHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        header.viewModel = viewModel
        header.delegate = self
        tableView.tableHeaderView = header
    }
    
    private func setupTableFooter(isLoading: Bool) {
        var footer: CharactersListFooterView
        if isLoading {
            footer = CharactersListFooterView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
            footer.setupLoader()
        } else {
            footer = CharactersListFooterView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
            footer.delegate = self
            if let viewModel = viewModel, viewModel.hasItemsToLoad {
                footer.setupAccessibilityItem()
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.tableFooterView = footer
        }
    }
}

extension CharactersListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getNumberOfCharacters()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListCell.identifier, for: indexPath) as? CharactersListCell,
              let viewModel = viewModel,
              let character = viewModel.getCharacterAt(indexPath.row) else {
            return UITableViewCell()
        }
        cell.setupData(with: character)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let character = viewModel.getCharacterAt(indexPath.row) else {
            return
        }
        didSelectCharacter(character)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CharactersListViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel else {
            return
        }
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        guard translation.y < 0 else { return }
        let position = scrollView.contentOffset.y
        let bottomSpace = tableView.contentSize.height - 20 - scrollView.frame.size.height
        if position > bottomSpace, viewModel.hasItemsToLoad, !viewModel.isLoadingRequest {
            self.loadMoreItems()
        }
    }
}

extension CharactersListViewController: CharactersListViewDelegateProtocol {
    func didSelectCharacter(_ character: Character) {
        let controller = CharacterInfoViewController()
        controller.viewModel = CharacterInfoViewModel(character: character)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CharactersListViewController: CharactersListFooterViewDelegate {
    func loadMoreItems() {
        setupTableFooter(isLoading: true)
        update()
    }
}
