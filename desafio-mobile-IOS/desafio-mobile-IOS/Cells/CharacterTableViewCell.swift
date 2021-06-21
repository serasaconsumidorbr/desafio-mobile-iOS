//
//  CharacterTableViewCell.swift
//  desafio-mobile-IOS
//
//  Created by Gustavo  Feliciano Figueiredo on 21/06/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var lbCharacterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
