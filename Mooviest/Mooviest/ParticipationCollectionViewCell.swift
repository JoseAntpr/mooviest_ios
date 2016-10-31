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
    var blurEffectView: UIVisualEffectView!
    
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
        
        captionView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        
        nameLabel.text = "Nombre"
        nameLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        nameLabel.textAlignment = .center
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 2
        nameLabel.font.withSize(nameLabel.font.pointSize*0.8)

        roleLabel.text = "Role"
        roleLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        roleLabel.textAlignment = .center
        roleLabel.font.withSize(roleLabel.font.pointSize*0.5)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        captionView.addSubview(blurEffectView)
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
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(faceImageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(faceImageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(faceImageView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(faceImageView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        addConstraint(captionView.bottomAnchor.constraint(equalTo: faceImageView.bottomAnchor))
        addConstraint(captionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(captionView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(captionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35))
        
        addConstraint(blurEffectView.bottomAnchor.constraint(equalTo: captionView.bottomAnchor))
        addConstraint(blurEffectView.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        addConstraint(blurEffectView.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        addConstraint(blurEffectView.heightAnchor.constraint(equalTo: captionView.heightAnchor))
        
        captionView.addConstraint(nameLabel.bottomAnchor.constraint(equalTo: captionView.bottomAnchor))
        captionView.addConstraint(nameLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        captionView.addConstraint(nameLabel.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        captionView.addConstraint(nameLabel.heightAnchor.constraint(equalTo: captionView.heightAnchor, multiplier: 0.6))
        
        captionView.addConstraint(roleLabel.topAnchor.constraint(equalTo: captionView.topAnchor))
        captionView.addConstraint(roleLabel.leftAnchor.constraint(equalTo: captionView.leftAnchor))
        captionView.addConstraint(roleLabel.widthAnchor.constraint(equalTo: captionView.widthAnchor))
        captionView.addConstraint(roleLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor))
    }
}
