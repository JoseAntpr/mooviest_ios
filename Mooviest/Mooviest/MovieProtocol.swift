//
//  MovieProtocol.swift
//  Mooviest
//
//  Created by Antonio RG on 28/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

import UIKit
import Kingfisher

protocol MovieProtocol {
}

extension MovieProtocol {
    
    func loadMovieToView (coverView: CoverView, movie: MovieListInfo )-> CoverView {
        coverView.movieImageView.kf.setImage(with: URL(string: movie.image),placeholder: UIImage(named:  "noimage"))
        coverView.titleLabel.text = movie.title
        coverView.ratingLabel.text = "\(movie.average)"
        coverView.layer.masksToBounds = true
        return coverView
    }
    
    func loadParticipationToView (ParticipationCollectionViewCell pv: ParticipationCollectionViewCell, participation p: Participation )-> ParticipationCollectionViewCell {
        pv.faceImageView.kf.setImage(with:  URL(string: p.image),placeholder: UIImage(named:  "noimageprofile"))
        pv.nameLabel.text = p.name
        pv.roleLabel.text = p.role
        
        return pv
    }
    
    func loadRatingToView (RatingCollectionViewCell pv: RatingCollectionViewCell, Rating r: Rating )-> RatingCollectionViewCell {
        pv.faceImageView.image = UIImage(named:  r.name)
        pv.ratingLabel.text =  r.rating == 0 ? "_":"\(r.rating)"
        return pv
    }
}
