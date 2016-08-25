//
//  SwipeTabView.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit

class SwipeTabView: UIView {
    var SIZE_SMALL_BUTTON: CGFloat!
    var SIZE_BUTTON: CGFloat!
    var card_width: CGFloat!
    var card_height: CGFloat!
    var panelButtonView = UIView()
    var closedButton = UIButton(type: UIButtonType.System) as UIButton
    var clockButton = UIButton(type: UIButtonType.System) as UIButton
    var eyeButton = UIButton(type: UIButtonType.System) as UIButton
    var heartButton = UIButton(type: UIButtonType.System) as UIButton
    
    
    init(Card_width w: CGFloat, Card_height h: CGFloat ) {
        super.init(frame: CGRect.zero)
        card_width = w
        card_height = h
        SIZE_BUTTON = card_height * 0.2/2
        SIZE_SMALL_BUTTON = SIZE_BUTTON * 0.9
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
        addConstraint(panelButtonView.bottomAnchor.constraintEqualToAnchor(bottomAnchor,constant: -52 ))
        addConstraint(panelButtonView.widthAnchor.constraintEqualToAnchor(widthAnchor, multiplier: 0.87))
        addConstraint(panelButtonView.heightAnchor.constraintEqualToConstant(SIZE_BUTTON))
        
        let MARGIN: CGFloat = (card_width-(SIZE_SMALL_BUTTON*2)-(SIZE_BUTTON*2))/3
        print(panelButtonView.frame.size.width)
        
        panelButtonView.addConstraint(closedButton.leftAnchor.constraintEqualToAnchor(panelButtonView.leftAnchor))
        panelButtonView.addConstraint(closedButton.centerYAnchor.constraintEqualToAnchor(panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(closedButton.widthAnchor.constraintEqualToConstant(SIZE_SMALL_BUTTON))
        panelButtonView.addConstraint(closedButton.heightAnchor.constraintEqualToConstant(SIZE_SMALL_BUTTON))
        
        panelButtonView.addConstraint(clockButton.leftAnchor.constraintEqualToAnchor(closedButton.rightAnchor, constant: MARGIN))
        panelButtonView.addConstraint(clockButton.topAnchor.constraintEqualToAnchor(panelButtonView.topAnchor))
        panelButtonView.addConstraint(clockButton.widthAnchor.constraintEqualToConstant(SIZE_BUTTON))
        panelButtonView.addConstraint(clockButton.heightAnchor.constraintEqualToConstant(SIZE_BUTTON))
        
        panelButtonView.addConstraint(eyeButton.leftAnchor.constraintEqualToAnchor(clockButton.rightAnchor, constant: MARGIN))
        panelButtonView.addConstraint(eyeButton.topAnchor.constraintEqualToAnchor(panelButtonView.topAnchor))
        panelButtonView.addConstraint(eyeButton.widthAnchor.constraintEqualToConstant(SIZE_BUTTON))
        panelButtonView.addConstraint(eyeButton.heightAnchor.constraintEqualToConstant(SIZE_BUTTON))
        
        panelButtonView.addConstraint(heartButton.rightAnchor.constraintEqualToAnchor(panelButtonView.rightAnchor))
        panelButtonView.addConstraint(heartButton.centerYAnchor.constraintEqualToAnchor(panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(heartButton.widthAnchor.constraintEqualToConstant(SIZE_SMALL_BUTTON))
        panelButtonView.addConstraint(heartButton.heightAnchor.constraintEqualToConstant(SIZE_SMALL_BUTTON))
        
    }
    
}
