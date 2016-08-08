//
//  SwipeTabView.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit

class SwipeTabView: UIView {
    
    var panelButtonView = UIView()
    var closedButton = UIButton(type: UIButtonType.System) as UIButton
    var clockButton = UIButton(type: UIButtonType.System) as UIButton
    var eyeButton = UIButton(type: UIButtonType.System) as UIButton
    var heartButton = UIButton(type: UIButtonType.System) as UIButton
    
    
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
        
        panelButtonView.backgroundColor = UIColor.whiteColor()
        
        closedButton.setImage( UIImage(named: "closes")?.imageWithRenderingMode(.AlwaysOriginal), forState: UIControlState.Normal)
        clockButton.setImage( UIImage(named: "clock")?.imageWithRenderingMode(.AlwaysOriginal), forState: UIControlState.Normal)
        eyeButton.setImage( UIImage(named: "eye")?.imageWithRenderingMode(.AlwaysOriginal), forState: UIControlState.Normal)
        heartButton.setImage( UIImage(named: "heart")?.imageWithRenderingMode(.AlwaysOriginal), forState: UIControlState.Normal)
        
        
        addSubview(panelButtonView)
        panelButtonView.addSubview(closedButton)
        panelButtonView.addSubview(clockButton)
        panelButtonView.addSubview(eyeButton)
        panelButtonView.addSubview(heartButton)
        
    }
    
    func setupConstraints() {
        panelButtonView.translatesAutoresizingMaskIntoConstraints = false
        closedButton.translatesAutoresizingMaskIntoConstraints = false
        clockButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(panelButtonView.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(panelButtonView.bottomAnchor.constraintEqualToAnchor(bottomAnchor,constant: -65))
        addConstraint(panelButtonView.widthAnchor.constraintEqualToConstant(260))
        addConstraint(panelButtonView.heightAnchor.constraintEqualToConstant(50))
        
        panelButtonView.addConstraint(closedButton.leftAnchor.constraintEqualToAnchor(panelButtonView.leftAnchor))
        panelButtonView.addConstraint(closedButton.topAnchor.constraintEqualToAnchor(panelButtonView.topAnchor))
        panelButtonView.addConstraint(closedButton.widthAnchor.constraintEqualToConstant(50))
        panelButtonView.addConstraint(closedButton.heightAnchor.constraintEqualToConstant(50))
        
        panelButtonView.addConstraint(clockButton.leftAnchor.constraintEqualToAnchor(closedButton.rightAnchor, constant: 20))
        panelButtonView.addConstraint(clockButton.topAnchor.constraintEqualToAnchor(panelButtonView.topAnchor))
        panelButtonView.addConstraint(clockButton.widthAnchor.constraintEqualToConstant(50))
        panelButtonView.addConstraint(clockButton.heightAnchor.constraintEqualToConstant(50))
        
        panelButtonView.addConstraint(eyeButton.leftAnchor.constraintEqualToAnchor(clockButton.rightAnchor, constant: 20))
        panelButtonView.addConstraint(eyeButton.topAnchor.constraintEqualToAnchor(panelButtonView.topAnchor))
        panelButtonView.addConstraint(eyeButton.widthAnchor.constraintEqualToConstant(50))
        panelButtonView.addConstraint(eyeButton.heightAnchor.constraintEqualToConstant(50))
        
        panelButtonView.addConstraint(heartButton.leftAnchor.constraintEqualToAnchor(eyeButton.rightAnchor, constant: 20))
        panelButtonView.addConstraint(heartButton.topAnchor.constraintEqualToAnchor(panelButtonView.topAnchor))
        panelButtonView.addConstraint(heartButton.widthAnchor.constraintEqualToConstant(50))
        panelButtonView.addConstraint(heartButton.heightAnchor.constraintEqualToConstant(50))
        
    }
    
}
