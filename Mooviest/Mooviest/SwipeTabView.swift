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
    var blackButton = UIButton(type: UIButtonType.system) as UIButton
    var watchButton = UIButton(type: UIButtonType.system) as UIButton
    var seenButton = UIButton(type: UIButtonType.system) as UIButton
    var favouriteButton = UIButton(type: UIButtonType.system) as UIButton
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
        
        blackButton.setImage( UIImage(named: "clear"), for: UIControlState())
        blackButton.tintColor = .white
        blackButton.backgroundColor = blacklist_color
        
        watchButton.setImage( UIImage(named: "bookmark"), for: UIControlState())
        watchButton.tintColor = .white
        watchButton.backgroundColor =  watchlist_color
        
        seenButton.setImage( UIImage(named: "eye"), for: UIControlState())
        seenButton.tintColor = .white
        seenButton.backgroundColor = seen_color
        
        favouriteButton.setImage( UIImage(named: "star"), for: UIControlState())
        favouriteButton.tintColor = .white
        favouriteButton.backgroundColor = favourite_color        
        
        panelButtonView.addSubview(blackButton)
        panelButtonView.addSubview(watchButton)
        panelButtonView.addSubview(seenButton)
        panelButtonView.addSubview(favouriteButton)
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
        blackButton.translatesAutoresizingMaskIntoConstraints = false
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        seenButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
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
        
        panelButtonView.addConstraint(blackButton.leftAnchor.constraint(equalTo: panelButtonView.leftAnchor))
        panelButtonView.addConstraint(blackButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(blackButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(blackButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        
        panelButtonView.addConstraint(space1View.leftAnchor.constraint(equalTo: blackButton.rightAnchor))
        panelButtonView.addConstraint(space1View.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(space1View.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        panelButtonView.addConstraint(space1View.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        
        panelButtonView.addConstraint(watchButton.leftAnchor.constraint(equalTo: space1View.rightAnchor))
        panelButtonView.addConstraint(watchButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(watchButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(watchButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        
        panelButtonView.addConstraint(space2View.leftAnchor.constraint(equalTo: watchButton.rightAnchor))
        panelButtonView.addConstraint(space2View.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(space2View.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        panelButtonView.addConstraint(space2View.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        
        panelButtonView.addConstraint(seenButton.leftAnchor.constraint(equalTo: space2View.rightAnchor))
        panelButtonView.addConstraint(seenButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(seenButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(seenButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        
        panelButtonView.addConstraint(space3View.leftAnchor.constraint(equalTo: seenButton.rightAnchor))
        panelButtonView.addConstraint(space3View.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(space3View.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        panelButtonView.addConstraint(space3View.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthSpace))
        
        panelButtonView.addConstraint(favouriteButton.leftAnchor.constraint(equalTo: space3View.rightAnchor))
        panelButtonView.addConstraint(favouriteButton.centerYAnchor.constraint(equalTo: panelButtonView.centerYAnchor))
        panelButtonView.addConstraint(favouriteButton.widthAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
        panelButtonView.addConstraint(favouriteButton.heightAnchor.constraint(equalTo: panelButtonView.widthAnchor, multiplier: porcentWidthButton))
    }
}
