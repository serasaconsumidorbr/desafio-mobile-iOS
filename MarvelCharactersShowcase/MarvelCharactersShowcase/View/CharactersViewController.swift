//
//  CharactersViewController.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 18/08/22.
//

import UIKit

protocol CharactersViewControllerDelegate {
    func showCharacters(viewModel: [Character])
    func showError()
    func showLoading()
    func dismissLoading()
}

class CharactersViewController: UIViewController, CharactersViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var loadingView: SpiderManLoadingView?
    var errorAlert: ErrorAlert?
    var presenter: CharactersPresenter?
    var viewModel: [Character]?
    
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.loadItems()
        presenter?.fetchCharacters(offset: offset)
    }
    
    func setupViewController() {
        presenter = CharactersPresenter(viewController: self)
        loadingView = SpiderManLoadingView(vc: self)
        errorAlert = ErrorAlert(vc: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10.0
        tableView.register(UINib(nibName: "CharactersTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10.0
        collectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Carousel")
    }
    
    func showCharacters(viewModel: [Character]) {
        self.viewModel = viewModel
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.tableView.reloadData()
            self.offset = self.offset + 50
            self.dismissLoading()
        }
    }
    
    func showError() {
        CharactersRepository.isPaginating = true
        DispatchQueue.main.async {
            self.loadingView?.dismissLoading()
            self.errorAlert?.showError()
        }
    }
    
    func showLoading() {
        loadingView?.showLoading()
    }
    
    func dismissLoading() {
        loadingView?.dismissLoading()
    }
}

// MARK: - CollectionView Methods
extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count > 5 ? 5 : viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Carousel", for: indexPath) as? CharactersCollectionViewCell ?? CharactersCollectionViewCell()
        
        guard let viewModel = viewModel else { return CharactersCollectionViewCell() }
        
            
            cell.lblName.text = viewModel[indexPath.row].name
            
            if viewModel[indexPath.row].thumbnail.path.contains("image_not_available") {
                cell.charImg.image = UIImage(named: "missingImage")
            } else {
                if let url = URL(string: viewModel[indexPath.row].thumbnail.path + "." + viewModel[indexPath.row].thumbnail.`extension`) {
                    cell.charImg.sd_setImage(with: url, completed: nil)
                }
            }
        
        return cell
    }
}

// MARK: - TableView Methods
extension CharactersViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count - 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharactersTableViewCell ?? CharactersTableViewCell()
        
        
        var index = indexPath.row
        index = index + 5
        
        guard let viewModel = viewModel else { return CharactersTableViewCell() }
        
        cell.lblName.text = viewModel[index].name
        cell.lblComics.text = "Comics: \(viewModel[index].comics.available)"
        cell.lblSeries.text = "Series: \(viewModel[index].series.available)"
        cell.lblStories.text = "Stories: \(viewModel[index].stories.available)"
           
        
        
            if viewModel[index].thumbnail.path.contains("image_not_available") {
                cell.charImg.image = UIImage(named: "missingImage")
            } else {
                if let url = URL(string: viewModel[index].thumbnail.path + "." + viewModel[index].thumbnail.`extension`) {
                    cell.charImg.sd_setImage(with: url, completed: nil)
                }
            }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if CharactersRepository.isPaginating == false && self.viewModel != nil {
                showLoading()
                CharactersRepository.isPaginating = true
                presenter?.fetchCharacters(offset: self.offset)
            }
        }
    }
    
}
