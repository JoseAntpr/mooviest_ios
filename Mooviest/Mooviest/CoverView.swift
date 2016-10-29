//
//  CoverView.swift
//  Mooviest
//
//  Created by Antonio RG on 25/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class CoverView: UIView {
    var porcentCaption: CGFloat!
    var porcentTitle: CGFloat!
    let captionView = UIView()
    let ratingImageView = UIImageView()
    let ratingLabel = UILabel()
    let titleLabel = UILabel()
    
    let movieImageView = UIImageView()
    
    init(porcentCaption: CGFloat, porcentTitle: CGFloat) {
        super.init(frame: CGRect.zero)
        self.porcentCaption = porcentCaption
        self.porcentTitle = porcentTitle
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = UIColor.blue
        
        ratingImageView.image = UIImage(named: "star_rate")?.withRenderingMode(.alwaysTemplate)
        ratingImageView.tintColor = favourite_color
        ratingImageView.contentMode = .scaleToFill
        
        ratingLabel.text = "10.0"
        ratingLabel.textColor = .white
        
        titleLabel.text = "Titulo"
        titleLabel.textColor = .white        
        titleLabel.textAlignment = .center
        
        movieImageView.contentMode = .scaleToFill
        
        captionView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        captionView.addSubview(ratingImageView)
        captionView.addSubview(ratingLabel)
        captionView.addSubview(titleLabel)
        
        addSubview(movieImageView)
        addSubview(captionView)
    }
    
    func setupConstraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        captionView.translatesAutoresizingMaskIntoConstraints = false
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(movieImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(movieImageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieImageView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(movieImageView.heightAnchor.constraint(equalTo: heightAnchor))
        
        addConstraint(captionView.bottomAnchor.constraint(equalTo: bottomAnchor))
        addConstraint(captionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(captionView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(captionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: porcentCaption))
        
        addConstraint(titleLabel.topAnchor.constraint(equalTo: captionView.topAnchor))
        addConstraint(titleLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        addConstraint(titleLabel.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        addConstraint(titleLabel.heightAnchor.constraint(equalTo: captionView.heightAnchor, multiplier: 0.7))
        
        addConstraint(ratingImageView.bottomAnchor.constraint(equalTo: captionView.bottomAnchor))
        addConstraint(ratingImageView.heightAnchor.constraint(equalTo: captionView.heightAnchor, multiplier:porcentTitle))
        addConstraint(ratingImageView.rightAnchor.constraint(equalTo: captionView.centerXAnchor))
        addConstraint(ratingImageView.widthAnchor.constraint(equalTo: ratingImageView.heightAnchor))
        
        addConstraint(ratingLabel.topAnchor.constraint(equalTo: ratingImageView.topAnchor))
        addConstraint(ratingLabel.leftAnchor.constraint(equalTo: ratingImageView.rightAnchor))
        addConstraint(ratingLabel.rightAnchor.constraint(equalTo: captionView.rightAnchor))
        addConstraint(ratingLabel.bottomAnchor.constraint(equalTo: ratingImageView.bottomAnchor))
    }
}

