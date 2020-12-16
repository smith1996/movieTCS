//
//  MovieCell.swift
//  Movies
//
//  Created by Smith Huamani Hilario on 12/1/20.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImageView.layer.cornerRadius = 10.0
    }
    
    func configure(movie: Movie) {
        titleLabel.text = movie.title
        popularityLabel.text = "⭐️ \(movie.popularity)"
        let url = URL(string: "https://image.tmdb.org/t/p/original\(movie.backdropPath)")!
        movieImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "default-placeholder"))
    }
}
