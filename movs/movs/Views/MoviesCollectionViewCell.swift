//
//  MoviesCollectionViewCell.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieFavorite: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movie: Movie? {
        willSet {
            guard let movie = newValue else { return }
            let image = movie.image
            self.movieImage.image = image
            self.movieTitle.text = movie.title
            
            if image == nil {
                self.activityIndicator.startAnimating()
            }else{
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.backgroundColor = .darkGray
        self.containerView.roundedCorners()
        self.containerView.shadow()
        
        self.activityIndicator.color = .primary
        self.activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func favorite(_ sender: UIButton) {
        guard let movie = self.movie else { return }
        DataManager().save(movie)
    }
    
}
