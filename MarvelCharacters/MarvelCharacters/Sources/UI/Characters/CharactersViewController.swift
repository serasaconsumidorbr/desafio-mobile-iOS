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
    private let tableViewIdentifier = "EntityTableViewCell"
    private let carrouselIdentifier = "EntityTableViewCellCarousel"
    private let headerIdentifier = "EntityTableViewHeader"
    
    // MARK: - PUBLIC PROPERTIES
            
        weak var delegate: CharactersViewControllerDelegate?
    
    // MARK: - UI
    
    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EntityTableViewCell.self, forCellReuseIdentifier: tableViewIdentifier)
        tableView.register(EntityTableViewCellCarousel.self, forCellReuseIdentifier: carrouselIdentifier)
        tableView.register(EntityTableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
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
        title = "Marvel Characters"
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if (indexPath.row >= 1 && indexPath.row <= 5) {
           return 0
       }
       return tableView.rowHeight
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier)
        return header
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return viewModel.getCharacters()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: carrouselIdentifier, for: indexPath) as? EntityTableViewCellCarousel else {
                return UITableViewCell()
            }
            let characters = viewModel.getCharacters()
            guard (characters?[indexPath.row]) != nil else { return cell }
            cell.setupCell(with: .init(cell:
                                        [.init(title: characters?[0].name,
                                               description: characters?[0].description,
                                               imagePath: characters?[0].imagePath,
                                               imageExtension: characters?[0].imageExtension),
                                         .init(title: characters?[1].name,
                                                description: characters?[1].description,
                                                imagePath: characters?[1].imagePath,
                                                imageExtension: characters?[1].imageExtension),
                                         .init(title: characters?[2].name,
                                                description: characters?[2].description,
                                                imagePath: characters?[2].imagePath,
                                                imageExtension: characters?[2].imageExtension),
                                         .init(title: characters?[3].name,
                                                description: characters?[3].description,
                                                imagePath: characters?[3].imagePath,
                                                imageExtension: characters?[3].imageExtension),
                                         .init(title: characters?[4].name,
                                                description: characters?[4].description,
                                                imagePath: characters?[4].imagePath,
                                                imageExtension: characters?[4].imageExtension)]))
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as? EntityTableViewCell else {
                return UITableViewCell()
            }
            let characters = viewModel.getCharacters()
            guard let character = characters?[indexPath.row] else { return cell }
            cell.setupCell(with: .init(title: character.name,
                                       description: character.description,
                                       imagePath: character.imagePath,
                                       imageExtension: character.imageExtension))
            if indexPath.row <= 5 {
                cell.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let comicsCount = viewModel.getCharacters()?.count else { return }
        if indexPath.row == comicsCount - 6 {
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
