//
//  ParticipationCollectionViewCell.swift
//  Mooviest
//
//  Created by Antonio RG on 12/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ParticipationCollectionViewCell: UICollectionViewCell {
    let captionView = UIView()
    let roleLabel = UILabel()
    let nameLabel = UILabel()
    
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
        self.backgroundColor = .black
        
        faceImageView.contentMode = .scaleAspectFill
        faceImageView.clipsToBounds = true
        
        captionView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        
        nameLabel.text = "Nombre"
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.boldSystemFont(ofSize: nameLabel.font.pointSize)

        roleLabel.text = "Role"
        roleLabel.textColor = .white
        roleLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: nameLabel.font.pointSize)
        captionView.addSubview(nameLabel)
        captionView.addSubview(roleLabel)

        addSubview(faceImageView)
        addSubview(captionView)
    }
    
    func setupConstraints() {
        faceImageView.translatesAutoresizingMaskIntoConstraints = false
        captionView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(faceImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(faceImageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(faceImageView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(faceImageView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        addConstraint(captionView.bottomAnchor.constraint(equalTo: faceImageView.bottomAnchor))
        addConstraint(captionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(captionView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(captionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45))
        
        captionView.addConstraint(nameLabel.topAnchor.constraint(equalTo: captionView.topAnchor))
        captionView.addConstraint(nameLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        captionView.addConstraint(nameLabel.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        captionView.addConstraint(nameLabel.heightAnchor.constraint(equalTo: captionView.heightAnchor, multiplier: 0.7))
        
        captionView.addConstraint(roleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor))
        captionView.addConstraint(roleLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        captionView.addConstraint(roleLabel.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        captionView.addConstraint(roleLabel.bottomAnchor.constraint(equalTo: captionView.bottomAnchor, constant: -4))
    }
}
