//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Paola Alcantara Soares on 01/05/23.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var name: String?
    var heroes: [Hero] = []
    
    private let homeTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: "CollectionViewTableViewCell")
        table.backgroundColor = .cyan
        return table
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "PERSONAGENS"
        return label
    }()
    private lazy var imageHero: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 30
        image.layer.borderWidth = 5
        image.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        image.clipsToBounds = true
        return image
    }()
    
    private let nameHero: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let DescriptionHero: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func configCell(with hero: Hero) {
        nameHero.text = hero.name
        DescriptionHero.text = hero.description
        if let url = URL(string: hero.thumbnail.url) {
            imageHero.kf.indicatorType = .activity
            imageHero.kf.setImage(with: url)
        } else {
            imageHero.image = nil
        }
    }
    
    var loadingHeroes = false
    var currentPage = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(homeTableView)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
    }
    
    func loadHeroes() {
        loadingHeroes = true
        MarvelApi.loadHeros(name: name, page: currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                print("Total:", self.total, "- Já incluidos:", self.heroes.count)
                DispatchQueue.main.async {
                    self.loadingHeroes = false
                    self.titleLabel.text = "Nao foram encontrados Herois com o nome \(self.name)."
                }
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
                return UITableViewCell()
            }
//            cell.configure(with: <#T##[Hero]#>)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
    }
}




