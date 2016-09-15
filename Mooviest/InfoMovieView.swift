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
        self.backgroundColor = UIColor.white
        
        headerTitleView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        synopsislabel.text = NSLocalizedString("synopsislabel", comment: "Text label synopsis")
        synopsislabel.textColor = UIColor.darkGray
        
        synopsisTextView.text = "Texto de prueba"
        synopsisTextView.textContainer.lineFragmentPadding = 20
        synopsisTextView.textAlignment = NSTextAlignment.justified
        synopsisTextView.textColor = UIColor.gray
        
        headerTitleView.addSubview(synopsislabel)
        
        addSubview(headerTitleView)
        addSubview(synopsisTextView)
    }
    
    func setupConstraints() {
        headerTitleView.translatesAutoresizingMaskIntoConstraints = false
        synopsislabel.translatesAutoresizingMaskIntoConstraints = false
        synopsisTextView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(headerTitleView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerTitleView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerTitleView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(headerTitleView.heightAnchor.constraint(equalToConstant: 40))
        
        headerTitleView.addConstraint(synopsislabel.leftAnchor.constraint(equalTo: headerTitleView.leftAnchor, constant: 10))
        headerTitleView.addConstraint(synopsislabel.topAnchor.constraint(equalTo: headerTitleView.topAnchor))
        headerTitleView.addConstraint(synopsislabel.rightAnchor.constraint(equalTo: headerTitleView.rightAnchor))
        headerTitleView.addConstraint(synopsislabel.heightAnchor.constraint(equalTo: headerTitleView.heightAnchor))
        
        addConstraint(synopsisTextView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(synopsisTextView.topAnchor.constraint(equalTo: synopsislabel.bottomAnchor))
        addConstraint(synopsisTextView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(synopsisTextView.heightAnchor.constraint(equalToConstant: 120))
    }
}
