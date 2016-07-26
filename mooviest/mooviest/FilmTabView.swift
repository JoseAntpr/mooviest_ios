//
//  FilmTabView.swift
//  mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit

class FilmTabView: UIView {
    
    var label = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = UIColor.whiteColor()
        
        label.text = "Prueba"
      
        addSubview(label)
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(label.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(label.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(label.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(label.heightAnchor.constraintEqualToConstant(50))
        
    }

}
