//
//  AddPhotoView.swift
//  Mooviest
//
//  Created by Antonio RG on 20/11/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//


import UIKit

class AddPhotoView: UIView {
    var porcentCaption: CGFloat!
    var porcentRating: CGFloat!
    
    let cameraButton = UIButton(type: UIButtonType.system) as UIButton
    let photosButton = UIButton(type: UIButtonType.system) as UIButton
    let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        
        cameraButton.setImage(UIImage(named: "camera_icon"), for: UIControlState())
        cameraButton.setTitle("Camara", for: .normal)
        cameraButton.contentMode = .scaleToFill
        
        photosButton.setImage(UIImage(named: "photos_icon"), for: UIControlState())
        cameraButton.setTitle("Fotos", for: .normal)
        photosButton.contentMode = .scaleToFill
        
        addSubview(separatorView)
        addSubview(cameraButton)
        addSubview(photosButton)
       
    }
    
    func setupConstraints() {
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        photosButton.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(separatorView.widthAnchor.constraint(equalTo: heightAnchor))
        addConstraint(separatorView.heightAnchor.constraint(equalTo: heightAnchor))
        addConstraint(separatorView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(separatorView.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        addConstraint(cameraButton.widthAnchor.constraint(equalTo: heightAnchor))
        addConstraint(cameraButton.heightAnchor.constraint(equalTo: heightAnchor))
        addConstraint(cameraButton.rightAnchor.constraint(equalTo: separatorView.leftAnchor))
        addConstraint(cameraButton.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        addConstraint(photosButton.widthAnchor.constraint(equalTo: heightAnchor))
        addConstraint(photosButton.heightAnchor.constraint(equalTo: heightAnchor))
        addConstraint(photosButton.leftAnchor.constraint(equalTo: separatorView.rightAnchor))
        addConstraint(photosButton.centerYAnchor.constraint(equalTo: centerYAnchor))        
    }
}

