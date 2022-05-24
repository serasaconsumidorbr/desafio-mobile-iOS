//
//  CharacterView.swift
//  Marvels
//
//  Created by Moacir Ezequiel Lamego on 24/05/2022.
//

import Foundation
import UIKit
import iCarousel

class CharacterView: UIView {
    // MARK: - Closures
    
    // MARK: - Properts
    private var characterViewModel: CharacterViewModel?
    private var results: [Results]?

    lazy private var myCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .rotary
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .lightGray
        tv.dataSource = self
        tv.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.identified)
        
        let lb: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            label.textColor = .white
            label.text = "Personagens"
            
            return label
        }()
        
        tv.tableHeaderView = lb
        tv.tableHeaderView?.frame.size.height = 30
        
        tv.backgroundColor = .white
        
        tv.rowHeight = 400
        tv.estimatedRowHeight = 400
        
        return tv
    }()
    
    
    //MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setElementsVisual()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setElementsVisual() {
        setCarousel()
        setTableView()
    }
    
    private func setCarousel() {
        self.addSubview(myCarousel)
        
        let kHeight = UIScreen.main.bounds.height * 0.40
        
        NSLayoutConstraint.activate([
            myCarousel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            myCarousel.leftAnchor.constraint(equalTo: self.leftAnchor),
            myCarousel.rightAnchor.constraint(equalTo: self.rightAnchor),
            myCarousel.heightAnchor.constraint(equalToConstant: kHeight)
        ])
    }
    
    private func setTableView() {
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: myCarousel.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Publics
    
    func setData(viewModel: CharacterViewModel) {
        self.characterViewModel = viewModel
        
        let rSlice = viewModel.results?[5...]

        guard let rSlice = rSlice else { return }
        
        self.results = Array(rSlice)
        
        DispatchQueue.main.async {
            self.myCarousel.reloadData()
            self.tableView.reloadData()
        }
    }
}

extension CharacterView: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        let result = self.characterViewModel == nil ? 0 : 5
        
        return result
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let kHeight = UIScreen.main.bounds.height * 0.40
        let kWidth = UIScreen.main.bounds.width * 0.62
        
        let url = self.characterViewModel?.getThumbnail(row: index) ?? ""
        let title = self.characterViewModel?.getName(row: index) ?? ""
        let description = self.characterViewModel?.getDescription(row: index) ?? ""
        let view = ViewCarousel(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight),
                                url: url,
                                title: title,
                                description: description )

        view.backgroundColor = .black
        
        return view
    }
}

extension CharacterView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identified, for: indexPath) as! CharacterViewCell

        guard let res = self.results?[indexPath.row] else { return cell }
        
        let ext = res.thumbnail?.thumbnailExtension?.rawValue ?? ""
        let path = res.thumbnail?.path ?? ""
        let url = "\(path).\(ext)"
        
        let title = res.name
        let description = res.resultDescription
        
        cell.setData(url: url, title: title, description: description)
        
        return cell
    }
}
