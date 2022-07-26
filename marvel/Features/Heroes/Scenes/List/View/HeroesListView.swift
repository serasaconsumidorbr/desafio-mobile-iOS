//
//  HeroesListView.swift
//  Marvel (iOS)
//
//  Created by Matheus Custódio on 25/07/22.
//

import UIKit

protocol HeroesListViewDelegate: UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDelegate{
    
}

class HeroesListView: UIView {
    
    var delegate: HeroesListViewDelegate?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    func addSubViews() {
        addSubview(mainView)
    }
}



extension HeroesListView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        return CGSize(width: width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }

}


