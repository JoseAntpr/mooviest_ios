//
//  CaptionMovieView.swift
//  Mooviest
//
//  Created by Antonio RG on 28/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class CaptionMovieView: UIView {
    let typeLabel = UILabel()
    let titleLabel = UILabel()
    let ratingView = RatingCollectionViewCell()
    let releasedLabel = UILabel()
    let runtimeLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        typeLabel.text = "Pelicula"
        typeLabel.textAlignment = .center
        typeLabel.textColor = .darkGray
        
        titleLabel.text = "Titulo de la pelicula cargada"
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkGray
        
        runtimeLabel.text = "000 min"
        runtimeLabel.textAlignment = .right
        runtimeLabel.textColor = .darkGray
        
        releasedLabel.text = "2000"
        releasedLabel.textAlignment = .right
        releasedLabel.textColor = .darkGray
        
        ratingView.faceImageView.image = UIImage(named: "logo")
        
        addSubview(typeLabel)
        addSubview(titleLabel)
        addSubview(ratingView)
        addSubview(runtimeLabel)
        addSubview(releasedLabel)
    }
    
    func setupConstraints() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        runtimeLabel.translatesAutoresizingMaskIntoConstraints = false
        releasedLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthRating = CGFloat(0.2)
        addConstraint(ratingView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(ratingView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(ratingView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthRating))
        addConstraint(ratingView.heightAnchor.constraint(equalTo: ratingView.widthAnchor, multiplier: 1/0.7))
        
        addConstraint(typeLabel.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(typeLabel.leftAnchor.constraint(equalTo: ratingView.rightAnchor))
        addConstraint(typeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: (1-widthRating)*0.7))
        addConstraint(typeLabel.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor))
        
        addConstraint(releasedLabel.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(releasedLabel.leftAnchor.constraint(equalTo: typeLabel.rightAnchor))
        addConstraint(releasedLabel.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(releasedLabel.heightAnchor.constraint(equalTo: runtimeLabel.heightAnchor))
        
        addConstraint(runtimeLabel.topAnchor.constraint(equalTo: releasedLabel.bottomAnchor))
        addConstraint(runtimeLabel.leftAnchor.constraint(equalTo: typeLabel.rightAnchor))
        addConstraint(runtimeLabel.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(runtimeLabel.heightAnchor.constraint(equalTo: typeLabel.heightAnchor, multiplier: 0.5))
        
        addConstraint(titleLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor))
        addConstraint(titleLabel.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(titleLabel.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor))
    }
    
    func adjustFontSizeToFitHeight () {
//        ratingView.faceImageView.layer.masksToBounds = true
//        ratingView.faceImageView.layer.cornerRadius  = ratingView.faceImageView.frame.size.width*0.5
//        let heightLabel = ratingView.ratingLabel.frame.height
//        ratingView.ratingLabel.font = UIFont(name: ratingView.ratingLabel.font!.fontName, size:heightLabel)!
        ratingView.adjustFontSizeToFitHeight()
        let heightLabel = runtimeLabel.frame.height
        runtimeLabel.font = UIFont(name: runtimeLabel.font!.fontName, size: heightLabel*0.45)!
        
        releasedLabel.font = UIFont(name: releasedLabel.font!.fontName, size: heightLabel*0.5)!
        
        typeLabel.font = UIFont(name: typeLabel.font!.fontName, size: heightLabel*0.75)!
        
        titleLabel.font = UIFont(name: titleLabel.font!.fontName, size: heightLabel*0.7)!
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)

    }
}

