//
//  ViewController.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit
import Combine

fileprivate enum Section: Int, CaseIterable {
    case spotlight
    case normal
}

fileprivate typealias characterDataSource = UICollectionViewDiffableDataSource<Section, Character>
fileprivate typealias characterSnapshot = NSDiffableDataSourceSnapshot<Section,Character>

class AppViewController: UIViewController {
    
    var constraints = [NSLayoutConstraint]()
    var viewModel: MavenViewModel?
    private var subscriptions: Set<AnyCancellable> = .init()
    
    private let characterCellID = "character_cell"
    private let characterSpotlightCellID = "character_spotlight_cell"
    
    fileprivate var dataSource : characterDataSource!
    
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
                print("Carregando")
            case .failed(let error):
                print("Failed \(error.localizedDescription)")
            case .success(let value):
                self?.createSnapShot(from: value)
                break
            }
            
        }.store(in: &subscriptions)
        
        viewModel?.getAllCharacters()
        
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
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: self.characterCellID)
        collectionView.register(CharacterSpotlightCell.self, forCellWithReuseIdentifier: self.characterSpotlightCellID)
        collectionView.backgroundColor = UIColor.clear
    }
    
}

extension AppViewController {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return  UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch Section(rawValue: sectionIndex) {
                case .spotlight:
                    let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                        heightDimension: .fractionalHeight(1)))
                    
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                     heightDimension: .absolute(300)),
                                                                   subitems: [item])
                    
                    let section = NSCollectionLayoutSection(group: group)
                    
                    section.orthogonalScrollingBehavior = .continuous
                    
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
        var snapshot = characterSnapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(Array(characters[0...5]), toSection: Section.spotlight)
        snapshot.appendItems(Array(characters[5...]), toSection: Section.normal)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}
