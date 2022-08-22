//
//  CharactersCollectionViewCell.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 20/08/22.
//

import UIKit
import SDWebImage

class CharactersCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var charImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bottomView.layer.cornerRadius = 10.0
        charImg.layer.cornerRadius = 10.0
        lblName.adjustsFontSizeToFitWidth = true
        lblName.minimumScaleFactor = 0.2
    }
}
