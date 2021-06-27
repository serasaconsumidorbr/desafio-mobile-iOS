//
//  ViewController.swift
//  SerasaMarvel
//
//  Created by Tito Albino Evangelista da Silva Junior on 25/06/21.
//

import UIKit
import Combine

class AppViewController: UIViewController {
    
    var constraints = [NSLayoutConstraint]()
    var viewModel: MavenViewModel?
    private var subscriptions: Set<AnyCancellable> = .init()
    let characterCellID = "character_cell"
    private(set) var characters = [Character]()

    
    var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpViewUI()
        setupCollectionViewUI()
        
        setupCollectionViewBuild()
        
        viewModel?.$state.sink { [weak self] value in
            
            switch value {
            case .loading:
                print("Carregando")
            case .failed(let error):
                print("Failed \(error.localizedDescription)")
            case .success(let value):
                self?.characters = value
                self?.collectionView.reloadData()
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: self.characterCellID)
        collectionView.backgroundColor = UIColor.clear
        
    }
    
}

extension AppViewController :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        print("SeachController tapped.")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: characterCellID, for: indexPath) as! CharacterCell
        cell.character = self.characters[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.percentOfHeight(percente: 15.32))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

