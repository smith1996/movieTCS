//
//  CastCell.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/3/20.
//

import UIKit
import SDWebImage

class CastCell: UICollectionViewCell {

    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actorImageView.layer.cornerRadius = 10.0
    }
    
    func configure(cast: Cast) {
        nameLabel.text = cast.name
        let url = URL(string: "https://image.tmdb.org/t/p/original\(cast.profilePath ?? "")")!
        actorImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "default-placeholder"))
    }

}
