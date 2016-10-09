//
//  SwipeTabView.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit

class SwipeTabView: UIView {
    //Contants
    let porcentWidthBarButtons = CGFloat(0.86)
    let porcentHeightBarButtons = CGFloat(0.1)
    let spaceBottomBarButtons = CGFloat(5)
    
    let porcentWidthButton = CGFloat(0.16)
    ///
    
    var panelButtonView = UIView()
    var closedButton = UIButton(type: UIButtonType.system) as UIButton
    var clockButton = UIButton(type: UIButtonType.system) as UIButton
    var eyeButton = UIButton(type: UIButtonType.system) as UIButton
    var heartButton = UIButton(type: UIButtonType.system) as UIButton
    let space1View = UIView ()
    let space2View = UIView ()
    let space3View = UIView ()
    let panelSwipeView = UIView()
    
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
        
        panelButtonView.backgroundColor = UIColor.white
        
        closedButton.setImage( UIImage(named: "closes")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        clockButton.setImage( UIImage(named: "clock")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        eyeButton.setImage( UIImage(named: "eye")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        heartButton.setImage( UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal), for: UIControlState())
        
        panelButtonView.addSubview(closedButton)
        panelButtonView.addSubview(clockButton)
        panelButtonView.addSubview(eyeButton)
        panelButtonView.addSubview(heartButton)
        panelButtonView.addSubview(space1View)
        panelButtonView.addSubview(space2View)
        panelButtonView.addSubview(space3View)
        
        addSubview(panelButtonView)
        addSubview(panelSwipeView)
    }
    
    func setupConstraints() {
        panelButtonView.translatesAutoresizingMaskIntoConstraints = false
        closedButton.translatesAutoresizingMaskIntoConstraints = false
        clockButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        space1View.translatesAutoresizingMaskIntoConstraints = false
        space2View.translatesAutoresizingMaskIntoConstraints = false
        space3View.translatesAutoresizingMaskIntoConstraints = false
        panelSwipeView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(panelSwipeView.topAnchor.constraint(equalTo: topAnchor,constant: spaceBottomBarButtons))
        addConstraint(panelSwipeView.bottomAnchor.constraint(equalTo: panelButtonView.topAnchor))
        addConstraint(panelSwipeView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(panelSwipeView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: porcentWidthBarButtons))
        
        addConstraint(panelButtonView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(panelButtonView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -spaceBottomBarButtons))
        addConstraint(panelButtonView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: porcentWidthBarButtons))
        addConstraint(panelButtonView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: porcentWidthBarButtons*porcentWidthButton))
        
        let porcentWidthSpace = (1 - porcentWidthButton*4)/3
        
        panelButtonView.addConstraint(closedButton.leftAnchor.constraint(equalTo: panelButtonView.leftAnchor))
        panelButtonView.addConstraint(closedButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(closedButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(closedButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        
        panelButtonView.addConstraint(space1View.leftAnchor.constraint(equalTo: closedButton.rightAnchor))
        panelButtonView.addConstraint(space1View.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(space1View.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        panelButtonView.addConstraint(space1View.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        
        panelButtonView.addConstraint(clockButton.leftAnchor.constraint(equalTo: space1View.rightAnchor))
        panelButtonView.addConstraint(clockButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(clockButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(clockButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        
        panelButtonView.addConstraint(space2View.leftAnchor.constraint(equalTo: clockButton.rightAnchor))
        panelButtonView.addConstraint(space2View.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(space2View.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        panelButtonView.addConstraint(space2View.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        
        panelButtonView.addConstraint(eyeButton.leftAnchor.constraint(equalTo: space2View.rightAnchor))
        panelButtonView.addConstraint(eyeButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(eyeButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(eyeButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        
        panelButtonView.addConstraint(space3View.leftAnchor.constraint(equalTo: eyeButton.rightAnchor))
        panelButtonView.addConstraint(space3View.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(space3View.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        panelButtonView.addConstraint(space3View.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        
        panelButtonView.addConstraint(heartButton.leftAnchor.constraint(equalTo: space3View.rightAnchor))
        panelButtonView.addConstraint(heartButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(heartButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(heartButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
    }
}
