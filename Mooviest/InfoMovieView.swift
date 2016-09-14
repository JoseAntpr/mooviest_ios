//
//  InfoMovieView.swift
//  Mooviest
//
//  Created by Antonio RG on 12/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class InfoMovieView: UIView {
    
    var headerTitleView = UIView()
    var synopsislabel = UILabel()
    var synopsisTextView = UITextView()
    
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
        
        headerTitleView.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.2)
        
        synopsislabel.text = NSLocalizedString("synopsislabel", comment: "Text label synopsis")
        synopsislabel.textColor = UIColor.darkGrayColor()
        
        synopsisTextView.text = "Texto de prueba"
        synopsisTextView.textContainer.lineFragmentPadding = 20
        synopsisTextView.textAlignment = NSTextAlignment.Justified
        synopsisTextView.textColor = UIColor.grayColor()
        
        headerTitleView.addSubview(synopsislabel)
        
        addSubview(headerTitleView)
        addSubview(synopsisTextView)
    }
    
    func setupConstraints() {
        headerTitleView.translatesAutoresizingMaskIntoConstraints = false
        synopsislabel.translatesAutoresizingMaskIntoConstraints = false
        synopsisTextView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(headerTitleView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(headerTitleView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(headerTitleView.rightAnchor.constraintEqualToAnchor(rightAnchor))
        addConstraint(headerTitleView.heightAnchor.constraintEqualToConstant(40))

        headerTitleView.addConstraint(synopsislabel.leftAnchor.constraintEqualToAnchor(headerTitleView.leftAnchor, constant: 10))
        headerTitleView.addConstraint(synopsislabel.topAnchor.constraintEqualToAnchor(headerTitleView.topAnchor))
        headerTitleView.addConstraint(synopsislabel.rightAnchor.constraintEqualToAnchor(headerTitleView.rightAnchor))
        headerTitleView.addConstraint(synopsislabel.heightAnchor.constraintEqualToAnchor(headerTitleView.heightAnchor))
            
        addConstraint(synopsisTextView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(synopsisTextView.topAnchor.constraintEqualToAnchor(synopsislabel.bottomAnchor))
        addConstraint(synopsisTextView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(synopsisTextView.heightAnchor.constraintEqualToConstant(100))        
    }
}
