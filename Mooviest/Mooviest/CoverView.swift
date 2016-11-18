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
    var porcentRating: CGFloat!
    
    let captionView = UIView()
    let titleLabel = UILabel()
    
    let captionRatingView = UIView()
    let ratingImageView = UIImageView()
    let ratingLabel = UILabel()
    
    let movieImageView = UIImageView()
    let mooviestImageView = UIImageView()
    
    var blurEffectView: UIVisualEffectView!
    var blurEffectRatingView: UIVisualEffectView!
    
    init(porcentCaption: CGFloat, porcentRating: CGFloat) {
        super.init(frame: CGRect.zero)
        self.porcentCaption = porcentCaption
        self.porcentRating = porcentRating
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = .white
        movieImageView.contentMode = .scaleToFill
        mooviestImageView.contentMode = .scaleAspectFit
        mooviestImageView.image = UIImage(named:"Mooviest")?.withRenderingMode(.alwaysTemplate)
        mooviestImageView.tintColor = mooviest_red
        
        ratingImageView.image = UIImage(named: "star_rate")?.withRenderingMode(.alwaysTemplate)
        ratingImageView.tintColor = favourite_color
        ratingImageView.contentMode = .scaleToFill

        ratingLabel.text = "10.0"
        ratingLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        
        titleLabel.text = NSLocalizedString("textTitleLabel", comment: "Text of titleLabel")
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        
        captionRatingView.layer.cornerRadius = 5
        captionRatingView.layer.masksToBounds = true
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.5
        
        let blurEffectRating = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectRatingView = UIVisualEffectView(effect: blurEffectRating)
        blurEffectRatingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectRatingView.alpha = 0.5
        
        captionRatingView.addSubview(blurEffectRatingView)
        captionRatingView.addSubview(ratingImageView)
        captionRatingView.addSubview(ratingLabel)
        
        captionView.addSubview(blurEffectView)
        captionView.addSubview(titleLabel)
        addSubview(mooviestImageView)
        addSubview(movieImageView)
        addSubview(captionRatingView)
        addSubview(captionView)
    }
    
    func setupConstraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        captionView.translatesAutoresizingMaskIntoConstraints = false
        captionRatingView.translatesAutoresizingMaskIntoConstraints = false
        ratingImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectRatingView.translatesAutoresizingMaskIntoConstraints = false
        mooviestImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(movieImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(movieImageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieImageView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(movieImageView.heightAnchor.constraint(equalTo: heightAnchor))
        
        addConstraint(mooviestImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(mooviestImageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(mooviestImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7))
        addConstraint(mooviestImageView.bottomAnchor.constraint(equalTo: captionView.topAnchor))
        
        let margin = CGFloat(5)
        addConstraint(captionRatingView.topAnchor.constraint(equalTo: topAnchor, constant: -margin))
        addConstraint(captionRatingView.leftAnchor.constraint(equalTo: leftAnchor, constant: -margin))
        addConstraint(captionRatingView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: porcentRating))
        addConstraint(captionRatingView.heightAnchor.constraint(equalTo: captionRatingView.widthAnchor, multiplier: 0.45))
        
        addConstraint(blurEffectRatingView.bottomAnchor.constraint(equalTo: captionRatingView.bottomAnchor))
        addConstraint(blurEffectRatingView.leftAnchor.constraint(equalTo: captionRatingView.leftAnchor))
        addConstraint(blurEffectRatingView.widthAnchor.constraint(equalTo: captionRatingView.widthAnchor))
        addConstraint(blurEffectRatingView.heightAnchor.constraint(equalTo: captionRatingView.heightAnchor))
        
        addConstraint(ratingImageView.topAnchor.constraint(equalTo: captionRatingView.topAnchor, constant: margin))
        addConstraint(ratingImageView.bottomAnchor.constraint(equalTo: captionRatingView.bottomAnchor))
        addConstraint(ratingImageView.leftAnchor.constraint(equalTo: captionRatingView.leftAnchor, constant: margin))
        addConstraint(ratingImageView.widthAnchor.constraint(equalTo: ratingImageView.heightAnchor))
        
        addConstraint(ratingLabel.topAnchor.constraint(equalTo: ratingImageView.topAnchor))
        addConstraint(ratingLabel.leftAnchor.constraint(equalTo: ratingImageView.rightAnchor))
        addConstraint(ratingLabel.rightAnchor.constraint(equalTo: captionRatingView.rightAnchor))
        addConstraint(ratingLabel.bottomAnchor.constraint(equalTo: captionRatingView.bottomAnchor))
        
        addConstraint(captionView.bottomAnchor.constraint(equalTo: bottomAnchor))
        addConstraint(captionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(captionView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(captionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: porcentCaption))
        
        addConstraint(blurEffectView.bottomAnchor.constraint(equalTo: captionView.bottomAnchor))
        addConstraint(blurEffectView.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        addConstraint(blurEffectView.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        addConstraint(blurEffectView.heightAnchor.constraint(equalTo: captionView.heightAnchor))
        
        addConstraint(titleLabel.topAnchor.constraint(equalTo: captionView.topAnchor))
        addConstraint(titleLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        addConstraint(titleLabel.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        addConstraint(titleLabel.heightAnchor.constraint(equalTo: captionView.heightAnchor))
    }
}

