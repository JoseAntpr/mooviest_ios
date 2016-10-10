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
    var infoView = UIView()
    var castView = UIView()
    var seeView = UIView()
    
    var profileCardView = UIView()
    var coverImageView = UIImageView()
    var titleLabel = UILabel()
    
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
        
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_gray).withAlphaComponent(0.5)
        
        headerView.backgroundColor = UIColor(netHex: mooviest_red)
        headerBackdropImageView.image = UIImage(named: "backdrop")
        headerBackdropImageView.contentMode = UIViewContentMode.scaleAspectFill
 
        profileCardView.backgroundColor = .white
        coverImageView.image = UIImage(named: "contact")
        coverImageView.backgroundColor = UIColor.white
        coverImageView.contentMode = UIViewContentMode.scaleToFill
        coverImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        coverImageView.layer.borderWidth = 1.8
        coverImageView.layer.masksToBounds = true
        titleLabel.text = "body title"
        titleLabel.textAlignment = .center
        
        let items = ["SEGUIDORES", "SIGUIENDO", "FAMOSOS"]
        barSegmentedControl = UISegmentedControl(items: items)
        barSegmentedControl.selectedSegmentIndex = 0
        barSegmentedControl.tintColor = UIColor(netHex: mooviest_red)
        
        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.showsVerticalScrollIndicator = false
        infoView.backgroundColor = UIColor.orange
        castView.backgroundColor = UIColor.red
        seeView.backgroundColor = UIColor.yellow
        
        headerView.clipsToBounds = true
        
        headerView.addSubview(headerBackdropImageView)
        
        bodyScrollView.addSubview(seeView)
        bodyScrollView.addSubview(castView)
        bodyScrollView.addSubview(infoView)
        
        
        profileCardView.addSubview(coverImageView)
        profileCardView.addSubview(titleLabel)
        
        barSegmentedView.addSubview(barSegmentedControl)
        
        addSubview(headerView)
        addSubview(bodyScrollView)
        addSubview(profileCardView)
        addSubview(barSegmentedView)
        addSubview(backgroundStatusView)
    }
    
    func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerBackdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        castView.translatesAutoresizingMaskIntoConstraints = false
        seeView.translatesAutoresizingMaskIntoConstraints = false
        profileCardView.translatesAutoresizingMaskIntoConstraints = false
        
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
        addConstraint(profileCardView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(profileCardView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(profileCardView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.7))
        
        profileCardView.addConstraint(coverImageView.centerYAnchor.constraint(equalTo: profileCardView.topAnchor))
        profileCardView.addConstraint(coverImageView.centerXAnchor.constraint(equalTo: profileCardView.centerXAnchor))
        profileCardView.addConstraint(coverImageView.widthAnchor.constraint(equalTo: profileCardView.widthAnchor, multiplier: 0.4))
        profileCardView.addConstraint(coverImageView.heightAnchor.constraint(equalTo: profileCardView.widthAnchor, multiplier: 0.4))
        
        profileCardView.addConstraint(titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor,constant: 5))
        profileCardView.addConstraint(titleLabel.centerXAnchor.constraint(equalTo: profileCardView.centerXAnchor))
        profileCardView.addConstraint(titleLabel.heightAnchor.constraint(equalToConstant: 20))
        profileCardView.addConstraint(titleLabel.widthAnchor.constraint(equalToConstant: 100))
        
        addConstraint(bodyScrollView.topAnchor.constraint(equalTo: barSegmentedView.bottomAnchor))
        addConstraint(bodyScrollView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(bodyScrollView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(bodyScrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1.15))
        
        bodyScrollView.addConstraint(infoView.topAnchor.constraint(equalTo: bodyScrollView.topAnchor))
        bodyScrollView.addConstraint(infoView.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor,constant: 5))
        bodyScrollView.addConstraint(infoView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor,constant: -10))
        bodyScrollView.addConstraint(infoView.heightAnchor.constraint(equalTo: bodyScrollView.heightAnchor))
        
        bodyScrollView.addConstraint(castView.topAnchor.constraint(equalTo: bodyScrollView.topAnchor))
        bodyScrollView.addConstraint(castView.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor,constant: 5))
        bodyScrollView.addConstraint(castView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor,constant: -10))
        bodyScrollView.addConstraint(castView.heightAnchor.constraint(equalTo: bodyScrollView.heightAnchor))
        
        bodyScrollView.addConstraint(seeView.topAnchor.constraint(equalTo: bodyScrollView.topAnchor))
        bodyScrollView.addConstraint(seeView.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor,constant: 5))
        bodyScrollView.addConstraint(seeView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor,constant: -10))
        bodyScrollView.addConstraint(seeView.heightAnchor.constraint(equalTo: bodyScrollView.heightAnchor))
        
        addConstraint(barSegmentedView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor,constant: 10))
        addConstraint(barSegmentedView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(barSegmentedView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(barSegmentedView.heightAnchor.constraint(equalToConstant: 40))
        
        barSegmentedView.addConstraint(barSegmentedControl.topAnchor.constraint(equalTo: barSegmentedView.topAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.leftAnchor.constraint(equalTo: barSegmentedView.leftAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.rightAnchor.constraint(equalTo: barSegmentedView.rightAnchor,constant: -5))
        barSegmentedView.addConstraint(barSegmentedControl.bottomAnchor.constraint(equalTo: barSegmentedView.bottomAnchor,constant: -5))
    }
    
//    func adjustConerRadius(){
//        coverImageView.layer.cornerRadius = coverImageView.frame.width/2
//    }
    
    
}
