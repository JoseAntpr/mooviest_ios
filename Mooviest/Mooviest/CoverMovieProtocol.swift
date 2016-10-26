//
//  MoviewCollectionProtocol.swift
//  Mooviest
//
//  Created by Antonio RG on 25/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher

protocol CoverMovieProtocol {
}


extension CoverMovieProtocol {
    func loadMovieToView (coverView: CoverView, movie: MovieListInfo )-> CoverView {
        coverView.movieImageView.kf_setImage(with: URL(string: movie.image),placeholder: UIImage(named:  "noimage"))
        coverView.layer.cornerRadius = 5
        coverView.layer.masksToBounds = true
        coverView.titleLabel.text = movie.title
        coverView.ratingLabel.text = "\(movie.average)"
        
        return coverView
    }
}
