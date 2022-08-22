//
//  CharactersTableViewCell.swift
//  MarvelCharactersShowcase
//
//  Created by Henrique Legnaro on 21/08/22.
//

import UIKit
import SDWebImage

class CharactersTableViewCell: UITableViewCell {

    @IBOutlet weak var charImg: UIImageView!
    @IBOutlet weak var cardView: CardViewCell!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblComics: UILabel!
    @IBOutlet weak var lblSeries: UILabel!
    @IBOutlet weak var lblStories: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        // Initialization code
    }
    
    func setupCell() {
        charImg.image = UIImage(named: "missingImage")
        lblName.text = ""
        lblComics.text = ""
        lblSeries.text = ""
        lblStories.text = ""
        charImg.layer.cornerRadius = 10.0
        lblName.adjustsFontSizeToFitWidth = true
        lblName.minimumScaleFactor = 0.2
    }
}
