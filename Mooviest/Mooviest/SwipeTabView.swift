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
    
    let height = UIApplication.shared.statusBarFrame.size.height
    var heightNavBar:CGFloat!
    
    var backgroundStatusView = UIView()
    var headerView = UIView()
    var lineView = UIView()
    
    var panelButtonView = UIView()
    var closedButton = UIButton(type: UIButtonType.system) as UIButton
    var clockButton = UIButton(type: UIButtonType.system) as UIButton
    var eyeButton = UIButton(type: UIButtonType.system) as UIButton
    var heartButton = UIButton(type: UIButtonType.system) as UIButton
    let space1View = UIView ()
    let space2View = UIView ()
    let space3View = UIView ()
    let panelSwipeView = UIView()
    
    init(heightNavBar h: CGFloat) {
        super.init(frame: CGRect.zero)
        heightNavBar = h
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = UIColor.white
        
        backgroundStatusView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        headerView.backgroundColor =  barTintColor
        lineView.backgroundColor = UIColor.lightGray
        
        closedButton.setImage( UIImage(named: "clear"), for: UIControlState())
        closedButton.tintColor = .white
        closedButton.backgroundColor = blacklist_color
        
        clockButton.setImage( UIImage(named: "bookmark"), for: UIControlState())
        clockButton.tintColor = .white
        clockButton.backgroundColor =  watchlist_color
        
        eyeButton.setImage( UIImage(named: "eye"), for: UIControlState())
        eyeButton.tintColor = .white
        eyeButton.backgroundColor = seen_color
        
        heartButton.setImage( UIImage(named: "star"), for: UIControlState())
        heartButton.tintColor = .white
        heartButton.backgroundColor = favourite_color        
        
        panelButtonView.addSubview(closedButton)
        panelButtonView.addSubview(clockButton)
        panelButtonView.addSubview(eyeButton)
        panelButtonView.addSubview(heartButton)
        panelButtonView.addSubview(space1View)
        panelButtonView.addSubview(space2View)
        panelButtonView.addSubview(space3View)
        
        addSubview(panelButtonView)
        addSubview(panelSwipeView)
        addSubview(panelButtonView)
        addSubview(headerView)
        addSubview(lineView)
        addSubview(backgroundStatusView)
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        panelButtonView.translatesAutoresizingMaskIntoConstraints = false
        closedButton.translatesAutoresizingMaskIntoConstraints = false
        clockButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        space1View.translatesAutoresizingMaskIntoConstraints = false
        space2View.translatesAutoresizingMaskIntoConstraints = false
        space3View.translatesAutoresizingMaskIntoConstraints = false
        panelSwipeView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
        addConstraint(lineView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(lineView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(lineView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(lineView.heightAnchor.constraint(equalToConstant: 0.5))
        
        addConstraint(panelSwipeView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: spaceBottomBarButtons*2))
        addConstraint(panelSwipeView.bottomAnchor.constraint(equalTo: panelButtonView.topAnchor,constant: -spaceBottomBarButtons))
        addConstraint(panelSwipeView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(panelSwipeView.widthAnchor.constraint(equalTo: widthAnchor))
        
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
