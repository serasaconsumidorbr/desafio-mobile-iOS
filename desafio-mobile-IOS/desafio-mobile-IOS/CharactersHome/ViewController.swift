//
//  ViewController.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 14/06/21.
//

import UIKit

protocol CharactersDisplayLogic {
    func pullCharactersNames(names: [String])
    func pullCharactersImages(images: [UIImage])
}

class ViewController: UIViewController {
    // VIP Cicle
    var router: CharactersHomeRoutingLogic?
    var interactor: CharactersHomeBusinessLogic?
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var charactersNames: [String]?
    fileprivate var charactersImages: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharactersHomeConfigurator.config(vc: self)
        interactor?.downloadMarvelCharacters()
    }
}

extension ViewController: CharactersDisplayLogic{
    func pullCharactersImages(images: [UIImage]) {
        self.charactersImages = images
    }
    
    func pullCharactersNames(names: [String]) {
        self.charactersNames = names
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charactersNames?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        if let name = charactersNames?[indexPath.row] {
            if let imagesCount = charactersImages?.count, indexPath.row < imagesCount{
                cell.imageView?.image = charactersImages?[indexPath.row] ?? UIImage(named: "photo")
            }
            cell.lbCharacterName.text = name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.1
    }
}

