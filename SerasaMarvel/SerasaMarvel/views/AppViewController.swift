//
//  ViewController.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit
import Combine

fileprivate enum Section: Int, Hashable, CaseIterable {
    case spotlight
    case normal
}

fileprivate typealias characterDataSource = UICollectionViewDiffableDataSource<Section, Character>
fileprivate typealias characterSnapshot = NSDiffableDataSourceSnapshot<Section, Character>

class AppViewController: UIViewController {
    
    var constraints = [NSLayoutConstraint]()
    var viewModel: MavenViewModel?
    private var subscriptions: Set<AnyCancellable> = .init()
    
    private let characterCellID = "character_cell"
    private let characterSpotlightCellID = "character_spotlight_cell"
    
    fileprivate var dataSource : characterDataSource!
    
    private(set) var page = 0
    
    private lazy var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: AppViewController.createLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpViewUI()
        setupCollectionViewUI()
        
        setupCollectionViewBuild()
        dataSource = createDataSource()
        
        viewModel?.$state.sink { [weak self] value in
            
            switch value {
            case .loading:
                self?.loadingUI()
            case .failed(let error):
                self?.failedUI(from: error)
            case .success(let value):
                self?.createSnapShot(from: value)
                break
            }
            
        }.store(in: &subscriptions)
        
        viewModel?.getAllCharacters(page: nil)
        
        NSLayoutConstraint.activate(self.constraints)
        
    }
    
    func setupCollectionViewUI() {
        constraints.append(collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        self.view.addSubview(self.collectionView)
    }
    
    func setUpViewUI() {
        view.backgroundColor = .white
    }
    
    func setupCollectionViewBuild() {
        
        collectionView.delegate = self
        
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: self.characterCellID)
        collectionView.register(CharacterSpotlightCell.self, forCellWithReuseIdentifier: self.characterSpotlightCellID)
        collectionView.backgroundColor = UIColor.clear
    }
    
    func loadingUI() {
        self.collectionView.isScrollEnabled = false
    }
    
    func failedUI(from error : Error) {
        print("Failed \(error.localizedDescription)")
    }
    
}

extension AppViewController {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return  UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch Section(rawValue: sectionIndex) {
            case .spotlight:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 4
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.98),
                                                                                 heightDimension: .fractionalHeight(0.3)),
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets.bottom = 16
                section.contentInsets.top = 16
                return section
            case .normal:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                               heightDimension: .fractionalHeight(0.15)),
                                                             subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case nil:
                return nil
            }
        }
    }
    
    private func createDataSource() -> characterDataSource {
        return characterDataSource (collectionView: self.collectionView) {  [weak self] (collectionView, indexPath, character) -> UICollectionViewCell? in
            switch Section(rawValue: indexPath.section) {
            case .spotlight:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self!.characterSpotlightCellID, for: indexPath) as! CharacterSpotlightCell
                cell.character = character
                return cell
            case .normal:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self!.characterCellID, for: indexPath) as! CharacterCell
                cell.character = character
                return cell
            case nil:
                return nil
            }
        }
    }
    
    private func createSnapShot(from characters: [Character]) {
        self.collectionView.isScrollEnabled = true
        var snapshot = characterSnapshot()
        snapshot.appendSections(Section.allCases)
        
        DispatchQueue.global().async { [weak self] in
            
            let spotlightItens : [Character] = Array(characters[0...5])
            let normalItens  : [Character] = Array(characters[5...])
            
            DispatchQueue.main.async {
                snapshot.appendItems(spotlightItens, toSection: Section.spotlight)
                snapshot.appendItems(normalItens, toSection: Section.normal)
                self?.dataSource.apply(snapshot, animatingDifferences: false)
            }
        }
        
        
    }
    
}

extension AppViewController : UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        
        if offSetY > height - scrollView.frame.size.height {
            self.page += 1
            self.viewModel?.getAllCharacters(page: page)
            print("load more data")
        }
    }
    
}
