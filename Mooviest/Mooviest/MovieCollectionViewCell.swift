//
//  MovieCollectionViewCell.swift
//  Mooviest
//
//  Created by Antonio RG on 12/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    var movieImageView = UIImageView()
    
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
        movieImageView.contentMode = .scaleToFill
        
        addSubview(movieImageView)
    }
    
    func setupConstraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(movieImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(movieImageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieImageView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(movieImageView.heightAnchor.constraint(equalTo: heightAnchor))
        
    }
}

