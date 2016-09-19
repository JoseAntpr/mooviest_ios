//
//  RatingCollectionViewCell.swift
//  Mooviest
//
//  Created by Antonio RG on 15/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
    var faceImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = UIColor.blue
        faceImageView.contentMode = .scaleToFill
        
        addSubview(faceImageView)
    }
    
    func setupConstraints() {
        faceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(faceImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(faceImageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(faceImageView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(faceImageView.heightAnchor.constraint(equalTo: heightAnchor))
        
    }
}
