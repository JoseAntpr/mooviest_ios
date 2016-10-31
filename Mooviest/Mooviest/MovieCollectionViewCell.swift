//
//  MovieCollectionViewCell.swift
//  Mooviest
//
//  Created by Antonio RG on 12/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    var coverView:CoverView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        coverView = CoverView(porcentCaption: 0.3, porcentRating: 0.35)
        coverView.titleLabel.font.withSize(coverView.titleLabel.font.pointSize*0.8)
        coverView.titleLabel.lineBreakMode = .byWordWrapping
        coverView.titleLabel.numberOfLines = 2
        addSubview(coverView)
    }
    
    func setupConstraints() {
        coverView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(coverView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(coverView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(coverView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(coverView.heightAnchor.constraint(equalTo: heightAnchor))
    }
}

