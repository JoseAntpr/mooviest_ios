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
    var closedButton = UIButton(type: UIButtonType.system) as UIButton
    var clockButton = UIButton(type: UIButtonType.system) as UIButton
    var eyeButton = UIButton(type: UIButtonType.system) as UIButton
    var heartButton = UIButton(type: UIButtonType.system) as UIButton
    
    
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
        self.backgroundColor = UIColor.white
        
        panelButtonView.backgroundColor = UIColor.white
        
        closedButton.setImage( UIImage(named: "closes")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        clockButton.setImage( UIImage(named: "clock")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        eyeButton.setImage( UIImage(named: "eye")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        heartButton.setImage( UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        
        
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
        
        addConstraint(panelButtonView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(panelButtonView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -52 ))
        addConstraint(panelButtonView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.87))
        addConstraint(panelButtonView.heightAnchor.constraint(equalToConstant: SIZE_BUTTON))
        
        let MARGIN: CGFloat = (card_width-(SIZE_SMALL_BUTTON*2)-(SIZE_BUTTON*2))/3
        print(panelButtonView.frame.size.width)
        
        panelButtonView.addConstraint(closedButton.leftAnchor.constraint(equalTo: panelButtonView.leftAnchor))
        panelButtonView.addConstraint(closedButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(closedButton.widthAnchor.constraint(equalToConstant: SIZE_SMALL_BUTTON))
        panelButtonView.addConstraint(closedButton.heightAnchor.constraint(equalToConstant: SIZE_SMALL_BUTTON))
        
        panelButtonView.addConstraint(clockButton.leftAnchor.constraint(equalTo: closedButton.rightAnchor, constant: MARGIN))
        panelButtonView.addConstraint(clockButton.topAnchor.constraint(equalTo: panelButtonView.topAnchor))
        panelButtonView.addConstraint(clockButton.widthAnchor.constraint(equalToConstant: SIZE_BUTTON))
        panelButtonView.addConstraint(clockButton.heightAnchor.constraint(equalToConstant: SIZE_BUTTON))
        
        panelButtonView.addConstraint(eyeButton.leftAnchor.constraint(equalTo: clockButton.rightAnchor, constant: MARGIN))
        panelButtonView.addConstraint(eyeButton.topAnchor.constraint(equalTo: panelButtonView.topAnchor))
        panelButtonView.addConstraint(eyeButton.widthAnchor.constraint(equalToConstant: SIZE_BUTTON))
        panelButtonView.addConstraint(eyeButton.heightAnchor.constraint(equalToConstant: SIZE_BUTTON))
        
        panelButtonView.addConstraint(heartButton.rightAnchor.constraint(equalTo: panelButtonView.rightAnchor))
        panelButtonView.addConstraint(heartButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(heartButton.widthAnchor.constraint(equalToConstant: SIZE_SMALL_BUTTON))
        panelButtonView.addConstraint(heartButton.heightAnchor.constraint(equalToConstant: SIZE_SMALL_BUTTON))
        
    }
    
}
