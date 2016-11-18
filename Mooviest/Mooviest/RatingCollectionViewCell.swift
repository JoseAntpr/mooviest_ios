//
//  RatingCollectionViewCell.swift
//  Mooviest
//
//  Created by Antonio RG on 15/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
    let faceImageView = UIImageView()
    let ratingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        faceImageView.contentMode = .scaleToFill
        ratingLabel.text = "_"
        
        ratingLabel.textAlignment = .center
        ratingLabel.textColor = .darkGray
        addSubview(faceImageView)
        addSubview(ratingLabel)
    }
    
    func setupConstraints() {
        faceImageView.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(faceImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(faceImageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(faceImageView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(faceImageView.heightAnchor.constraint(equalTo: widthAnchor))
        
        addConstraint(ratingLabel.topAnchor.constraint(equalTo: faceImageView.bottomAnchor, constant: 4))
        addConstraint(ratingLabel.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(ratingLabel.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor))        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.adjustFontSizeToFitHeight()
    }
    
    func adjustFontSizeToFitHeight() {
        self.faceImageView.layer.masksToBounds = true
        self.faceImageView.layer.cornerRadius  = faceImageView.frame.size.width*0.5
        let heightLabel = ratingLabel.frame.height
        ratingLabel.font = UIFont(name: self.ratingLabel.font!.fontName, size:heightLabel)!
        ratingLabel.font = UIFont.boldSystemFont(ofSize: ratingLabel.font.pointSize)
    }
}
