//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by iris on 21/05/23.
//

import RxSwift
import UIKit

class CharactersViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private var viewModel: CharactersViewModelProtocol
    private let disposeBag = DisposeBag()
    private let reuseIdentifier = "EntityTableViewCell"
    
    // MARK: - PUBLIC PROPERTIES
            
        weak var delegate: CharactersViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EntityTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 182
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
//    private lazy var searchBar: UISearchController = {
//        let searchController = UISearchController()
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.placeholder = "Search for comic title"
//        return searchController
//    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
    private lazy var feedbackLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - LIFE CYCLE
    
    init(viewModel: CharactersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.retrieveCharacters(asPagination: false)
        setupView()
        buildViewHierarchy()
        constraintUI()
        bindObservables()
    }
    
    // MARK: - SETUP
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Comics"
    }
    
    private func buildViewHierarchy() {
        view.addSubview(charactersTableView)
        view.addSubview(spinner)
        view.addSubview(feedbackLabel)
    }
    
    private func constraintUI() {
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: view.topAnchor),
            spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            charactersTableView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            charactersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            feedbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedbackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            feedbackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            feedbackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func bindObservables() {
        viewModel.viewState
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.handleViewState(state)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - HANDLERS
    
    private func handleViewState(_ viewState: CharactersViewState) {
        switch viewState {
        case .loading(let asPagination):
            handleLoading(asPagination: asPagination)
        case .success(let asPagination):
            handleContent(asPagination: asPagination)
        case .error(let error):
            handleError(error)
        }
    }
    
    private func handleLoading(asPagination: Bool) {
        asPagination ? startPaginationLoadingAnimation() : startScreenLoadingAnimation()
    }
    
    private func handleContent(asPagination: Bool) {
        asPagination ? stopPaginationLoadingAnimation() : stopScreenLoadingAnimation()
        charactersTableView.reloadData()
    }
    
    private func handleError(_ error: Error) {
        stopScreenLoadingAnimation()
        stopPaginationLoadingAnimation()
        showFeebackErrorLabel(error)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    private func startPaginationLoadingAnimation() {
        charactersTableView.tableFooterView = createSpinnerFooter()
    }
    
    private func stopPaginationLoadingAnimation() {
        charactersTableView.tableFooterView = nil
    }
    
    private func startScreenLoadingAnimation() {
        charactersTableView.isHidden = true
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    private func stopScreenLoadingAnimation() {
        spinner.stopAnimating()
        spinner.isHidden = true
        charactersTableView.isHidden = false
    }
    
    private func showFeebackErrorLabel(_ error: Error) {
        charactersTableView.isHidden = true
        navigationItem.searchController?.searchBar.isHidden = true
        feedbackLabel.text = "We had problems fetching data. Error: \(error.localizedDescription)"
        feedbackLabel.isHidden = false
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (viewModel.getCharacter(at: indexPath.row)) != nil else { return }
        //delegate?.characterViewController(didTapCharacter: character)
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCharacters()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? EntityTableViewCell else {
            return UITableViewCell()
        }
        let characters = viewModel.getCharacters()
        guard let character = characters?[indexPath.row] else { return cell }
        cell.setupCell(with: .init(title: character.name,
                                   description: character.description,
                                   imagePath: character.imagePath,
                                   imageExtension: character.imageExtension))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let comicsCount = viewModel.getCharacters()?.count else { return }
        if indexPath.row == comicsCount - 3 {
            guard !viewModel.isPaginating else { return }
            viewModel.retrieveCharacters(asPagination: true)
        }
    }
}

//extension CharactersViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        if let text = searchController.searchBar.text,
//           !text.isEmpty {
//            viewModel.filterModel = FilterSearchModel(text: text)
//        } else {
//            viewModel.filterModel = nil
//        }
//        charactersTableView.reloadData()
//    }
//}
