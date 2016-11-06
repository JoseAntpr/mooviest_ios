//
//  ProfileView.swift
//  Mooviest
//
//  Created by Antonio RG on 9/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    let height = UIApplication.shared.statusBarFrame.size.height
    var backgroundStatusView = UIView()
    
    var headerView = UIView()
    var headerBackdropImageView = UIImageView()
    
    var bodyScrollView = UIScrollView()
    var tabsView = UIView()
    var followersView = UIView()
    let InfoLabel = UILabel()
    var followingView = UIView()
    let Info2Label = UILabel()
    
    
    var profileCardView = UIView()
    var coverImageView = UIImageView()
    var usernameLabel = UILabel()
    let firstnameLabel = UILabel()
    let lastnameLabel = UILabel()
    
    var barSegmentedView = UIView()
    var barSegmentedControl: UISegmentedControl!
    
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
        
        backgroundStatusView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        headerView.backgroundColor =   .white
        headerBackdropImageView.image = UIImage(named: "backdrop")?.withRenderingMode(.alwaysTemplate)
        headerBackdropImageView.tintColor = mooviest_red
        headerBackdropImageView.contentMode = UIViewContentMode.scaleAspectFill
 
        profileCardView.backgroundColor = .white
        coverImageView.image = UIImage(named: "contact")
        coverImageView.backgroundColor = UIColor.white
        
        let porcentSize = CGFloat(0.7)
        usernameLabel.text = "email@gmail.com"
        usernameLabel.textAlignment = .center
        usernameLabel.font.withSize(usernameLabel.font.capHeight*porcentSize)
        usernameLabel.textColor = .darkGray
        
        firstnameLabel.text = "firstnameLabel"
        firstnameLabel.textAlignment = .left
        firstnameLabel.font.withSize(firstnameLabel.font.capHeight*porcentSize)
        firstnameLabel.textColor = .darkGray
        
        lastnameLabel.text = "lastnameLabel"
        lastnameLabel.textAlignment = .left
        lastnameLabel.font.withSize(lastnameLabel.font.capHeight*porcentSize)
        lastnameLabel.textColor = .darkGray
        
        let items = ["SEGUIDORES 0", "SIGUIENDO 0"]
        barSegmentedControl = UISegmentedControl(items: items)
        barSegmentedControl.selectedSegmentIndex = 0
        barSegmentedControl.tintColor =   mooviest_red
        
        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.showsVerticalScrollIndicator = false
        
        headerView.clipsToBounds = true
        
        InfoLabel.text = "Proximamente..."
        InfoLabel.textColor = .darkGray
        InfoLabel.font = UIFont.boldSystemFont(ofSize: InfoLabel.font.pointSize)
        InfoLabel.textAlignment = .center
        
        Info2Label.text = "Proximamente..."
        Info2Label.textColor = .darkGray
        Info2Label.font = UIFont.boldSystemFont(ofSize: InfoLabel.font.pointSize)
        Info2Label.textAlignment = .center
        
        headerView.addSubview(headerBackdropImageView)
        
        followersView.addSubview(InfoLabel)
        followingView.addSubview(Info2Label)
        tabsView.addSubview(followingView)
        tabsView.addSubview(followersView)
        
        profileCardView.addSubview(coverImageView)
        profileCardView.addSubview(usernameLabel)
        profileCardView.addSubview(firstnameLabel)
        profileCardView.addSubview(lastnameLabel)
        
        barSegmentedView.addSubview(barSegmentedControl)
        
        addSubview(headerView)
        addSubview(tabsView)
        addSubview(profileCardView)
        addSubview(bodyScrollView)
        addSubview(barSegmentedView)
        addSubview(backgroundStatusView)
    }
    
    func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        tabsView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerBackdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        followersView.translatesAutoresizingMaskIntoConstraints = false
        followingView.translatesAutoresizingMaskIntoConstraints = false
        profileCardView.translatesAutoresizingMaskIntoConstraints = false
        InfoLabel.translatesAutoresizingMaskIntoConstraints = false
        Info2Label.translatesAutoresizingMaskIntoConstraints = false
        firstnameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastnameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4))
        
        headerView.addConstraint(headerBackdropImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor))
        headerView.addConstraint(headerBackdropImageView.widthAnchor.constraint(equalTo: headerView.widthAnchor))
        headerView.addConstraint(headerBackdropImageView.topAnchor.constraint(equalTo: headerView.topAnchor))
        headerView.addConstraint(headerBackdropImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor))
        
        addConstraint(profileCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(profileCardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5))
        addConstraint(profileCardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5))
        addConstraint(profileCardView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.7))
        
        profileCardView.addConstraint(coverImageView.centerYAnchor.constraint(equalTo: profileCardView.topAnchor))
        profileCardView.addConstraint(coverImageView.centerXAnchor.constraint(equalTo: profileCardView.centerXAnchor))
        profileCardView.addConstraint(coverImageView.widthAnchor.constraint(equalTo: profileCardView.widthAnchor, multiplier: 0.4))
        profileCardView.addConstraint(coverImageView.heightAnchor.constraint(equalTo: profileCardView.widthAnchor, multiplier: 0.4))
        
        let margin = CGFloat(5)
        profileCardView.addConstraint(usernameLabel.heightAnchor.constraint(equalTo: firstnameLabel.heightAnchor))
        profileCardView.addConstraint(usernameLabel.centerXAnchor.constraint(equalTo: profileCardView.centerXAnchor))
        profileCardView.addConstraint(usernameLabel.bottomAnchor.constraint(equalTo:  profileCardView.bottomAnchor))
        profileCardView.addConstraint(usernameLabel.widthAnchor.constraint(equalTo: profileCardView.widthAnchor, multiplier: 0.5))
        
        profileCardView.addConstraint(firstnameLabel.leftAnchor.constraint(equalTo: profileCardView.leftAnchor))
        profileCardView.addConstraint(firstnameLabel.bottomAnchor.constraint(equalTo: lastnameLabel.topAnchor, constant: -margin))
        profileCardView.addConstraint(firstnameLabel.heightAnchor.constraint(equalTo: profileCardView.heightAnchor, multiplier:1/4))
        profileCardView.addConstraint(firstnameLabel.rightAnchor.constraint(equalTo: coverImageView.leftAnchor))
        
        profileCardView.addConstraint(lastnameLabel.leftAnchor.constraint(equalTo: profileCardView.leftAnchor))
        profileCardView.addConstraint(lastnameLabel.centerYAnchor.constraint(equalTo: profileCardView.centerYAnchor, constant: -margin))
        profileCardView.addConstraint(lastnameLabel.heightAnchor.constraint(equalTo: firstnameLabel.heightAnchor))
        profileCardView.addConstraint(lastnameLabel.rightAnchor.constraint(equalTo: coverImageView.leftAnchor))
        
        addConstraint(bodyScrollView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(bodyScrollView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(bodyScrollView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(bodyScrollView.heightAnchor.constraint(equalTo: heightAnchor))

        addConstraint(tabsView.topAnchor.constraint(equalTo: barSegmentedView.bottomAnchor))
        addConstraint(tabsView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(tabsView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(tabsView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.15))
        
        tabsView.addConstraint(followersView.topAnchor.constraint(equalTo: tabsView.topAnchor))
        tabsView.addConstraint(followersView.leftAnchor.constraint(equalTo: tabsView.leftAnchor,constant: 5))
        tabsView.addConstraint(followersView.widthAnchor.constraint(equalTo: tabsView.widthAnchor,constant: -10))
        tabsView.addConstraint(followersView.heightAnchor.constraint(equalTo: tabsView.heightAnchor))
        
        followersView.addConstraint(InfoLabel.topAnchor.constraint(equalTo: followersView.topAnchor, constant:50))
        followersView.addConstraint(InfoLabel.leftAnchor.constraint(equalTo: followersView.leftAnchor))
        followersView.addConstraint(InfoLabel.widthAnchor.constraint(equalTo: followersView.widthAnchor))
        followersView.addConstraint(InfoLabel.heightAnchor.constraint(equalTo: followersView.heightAnchor, multiplier:0.1))
        
        tabsView.addConstraint(followingView.topAnchor.constraint(equalTo: tabsView.topAnchor))
        tabsView.addConstraint(followingView.leftAnchor.constraint(equalTo: tabsView.leftAnchor,constant: 5))
        tabsView.addConstraint(followingView.widthAnchor.constraint(equalTo: tabsView.widthAnchor,constant: -10))
        tabsView.addConstraint(followingView.heightAnchor.constraint(equalTo: tabsView.heightAnchor))
        
        followingView.addConstraint(Info2Label.topAnchor.constraint(equalTo: followingView.topAnchor, constant:50))
        followingView.addConstraint(Info2Label.leftAnchor.constraint(equalTo: followingView.leftAnchor))
        followingView.addConstraint(Info2Label.widthAnchor.constraint(equalTo: followingView.widthAnchor))
        followingView.addConstraint(Info2Label.heightAnchor.constraint(equalTo: followingView.heightAnchor, multiplier:0.1))
        
        addConstraint(barSegmentedView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor,constant: 10))
        addConstraint(barSegmentedView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(barSegmentedView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(barSegmentedView.heightAnchor.constraint(equalToConstant: 40))
        
        barSegmentedView.addConstraint(barSegmentedControl.topAnchor.constraint(equalTo: barSegmentedView.topAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.leftAnchor.constraint(equalTo: barSegmentedView.leftAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.rightAnchor.constraint(equalTo: barSegmentedView.rightAnchor,constant: -5))
        barSegmentedView.addConstraint(barSegmentedControl.bottomAnchor.constraint(equalTo: barSegmentedView.bottomAnchor,constant: -5))
    }
}
