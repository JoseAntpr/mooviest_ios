//
//  MovieDetailView.swift
//  Mooviest
//
//  Created by Antonio RG on 5/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    
    let height = UIApplication.shared.statusBarFrame.size.height
    let heightSegmentedView = CGFloat(40)
    var heightNavBar:CGFloat!
    
    let backgroundStatusView = UIView()
    
    let headerView = UIView()
    let headerBackdropImageView = UIImageView()
    
    let bodyScrollView = UIScrollView()
    
    let tabsView = UIView()
    var profileCardView = UIView()
    let coverImageView = UIImageView()
    let titleLabel = UILabel()
    
    let infoScrollView = UIScrollView()
    let infoView = InfoMovieView()
    var castCollectionView:UICollectionView!
    let seeScrollView = UIScrollView()
    let seeView = UIView()
    
    let barSegmentedView = UIView()
    var barSegmentedControl: UISegmentedControl!
    
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
        
        headerView.backgroundColor = UIColor(netHex: mooviest_red)
        
        titleLabel.text = "body title"
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_gray).withAlphaComponent(0.5)
        
        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.showsVerticalScrollIndicator = false
        
        let items = ["INFORMACIÓN", "REPARTO", "VER"]
        barSegmentedControl = UISegmentedControl(items: items)
        barSegmentedControl.selectedSegmentIndex = 0
        barSegmentedControl.tintColor = UIColor(netHex: mooviest_red)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        castCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        castCollectionView.backgroundColor = UIColor.white
        seeView.backgroundColor = UIColor.yellow
        
        headerView.clipsToBounds = true
        
        headerView.addSubview(headerBackdropImageView)
        
        profileCardView.addSubview(titleLabel)
        profileCardView.addSubview(coverImageView)
        
        seeScrollView.addSubview(seeView)
        infoScrollView.addSubview(infoView)
        
        tabsView.addSubview(seeScrollView)
        tabsView.addSubview(castCollectionView)
        tabsView.addSubview(infoScrollView)
        
        barSegmentedView.addSubview(barSegmentedControl)
        
        addSubview(headerView)
        
        addSubview(tabsView)
        addSubview(profileCardView)
        addSubview(bodyScrollView)
        addSubview(backgroundStatusView)
        addSubview(barSegmentedView)
    }
    
    func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        tabsView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerBackdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        castCollectionView.translatesAutoresizingMaskIntoConstraints = false
        seeView.translatesAutoresizingMaskIntoConstraints = false
        profileCardView.translatesAutoresizingMaskIntoConstraints = false
        seeScrollView.translatesAutoresizingMaskIntoConstraints = false
        infoScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalTo: widthAnchor,multiplier: 0.5))        
        
        headerView.addConstraint(headerBackdropImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor))
        headerView.addConstraint(headerBackdropImageView.widthAnchor.constraint(equalTo: headerView.widthAnchor))
        headerView.addConstraint(headerBackdropImageView.topAnchor.constraint(equalTo: headerView.topAnchor))
        headerView.addConstraint(headerBackdropImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor))
        
        addConstraint(profileCardView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(profileCardView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(profileCardView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(profileCardView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.7))
        
        profileCardView.addConstraint(coverImageView.centerYAnchor.constraint(equalTo: profileCardView.topAnchor))
        profileCardView.addConstraint(coverImageView.leftAnchor.constraint(equalTo: profileCardView.leftAnchor, constant: 20))
        profileCardView.addConstraint(coverImageView.widthAnchor.constraint(equalTo: coverImageView.heightAnchor, multiplier: 0.7))
        profileCardView.addConstraint(coverImageView.heightAnchor.constraint(equalTo: profileCardView.heightAnchor, multiplier: 1.7))
        
        profileCardView.addConstraint(titleLabel.centerYAnchor.constraint(equalTo: profileCardView.centerYAnchor,constant: 5))
        profileCardView.addConstraint(titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 10))
        profileCardView.addConstraint(titleLabel.heightAnchor.constraint(equalToConstant: 20))
        profileCardView.addConstraint(titleLabel.widthAnchor.constraint(equalToConstant: 100))
        
        addConstraint(bodyScrollView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(bodyScrollView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(bodyScrollView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(bodyScrollView.heightAnchor.constraint(equalTo: heightAnchor))
        
        let heightTabsView = -heightNavBar-height-heightSegmentedView
        addConstraint(tabsView.topAnchor.constraint(equalTo: barSegmentedView.bottomAnchor))
        addConstraint(tabsView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(tabsView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(tabsView.heightAnchor.constraint(equalTo: heightAnchor,constant: heightTabsView))
        
        tabsView.addConstraint(infoScrollView.topAnchor.constraint(equalTo: tabsView.topAnchor))
        tabsView.addConstraint(infoScrollView.leftAnchor.constraint(equalTo: tabsView.leftAnchor))
        tabsView.addConstraint(infoScrollView.widthAnchor.constraint(equalTo: tabsView.widthAnchor))
        tabsView.addConstraint(infoScrollView.heightAnchor.constraint(equalTo: tabsView.heightAnchor))
        
        infoScrollView.addConstraint(infoView.topAnchor.constraint(equalTo: infoScrollView.topAnchor))
        infoScrollView.addConstraint(infoView.leftAnchor.constraint(equalTo: infoScrollView.leftAnchor))
        infoScrollView.addConstraint(infoView.widthAnchor.constraint(equalTo: infoScrollView.widthAnchor))
        infoScrollView.addConstraint(infoView.heightAnchor.constraint(equalTo: infoScrollView.heightAnchor))
        
        tabsView.addConstraint(castCollectionView.topAnchor.constraint(equalTo: tabsView.topAnchor))
        tabsView.addConstraint(castCollectionView.leftAnchor.constraint(equalTo: tabsView.leftAnchor,constant: 5))
        tabsView.addConstraint(castCollectionView.widthAnchor.constraint(equalTo: tabsView.widthAnchor,constant: -10))
        tabsView.addConstraint(castCollectionView.heightAnchor.constraint(equalTo: tabsView.heightAnchor))
        
        tabsView.addConstraint(seeScrollView.topAnchor.constraint(equalTo: tabsView.topAnchor))
        tabsView.addConstraint(seeScrollView.leftAnchor.constraint(equalTo: tabsView.leftAnchor,constant: 5))
        tabsView.addConstraint(seeScrollView.widthAnchor.constraint(equalTo: tabsView.widthAnchor,constant: -10))
        tabsView.addConstraint(seeScrollView.heightAnchor.constraint(equalTo: tabsView.heightAnchor))
        
        seeScrollView.addConstraint(seeView.topAnchor.constraint(equalTo: seeScrollView.topAnchor))
        seeScrollView.addConstraint(seeView.leftAnchor.constraint(equalTo: seeScrollView.leftAnchor))
        seeScrollView.addConstraint(seeView.widthAnchor.constraint(equalTo: seeScrollView.widthAnchor))
        seeScrollView.addConstraint(seeView.heightAnchor.constraint(equalTo: seeScrollView.heightAnchor))
        
        addConstraint(barSegmentedView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor))
        addConstraint(barSegmentedView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(barSegmentedView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(barSegmentedView.heightAnchor.constraint(equalToConstant: heightSegmentedView))
        
        barSegmentedView.addConstraint(barSegmentedControl.topAnchor.constraint(equalTo: barSegmentedView.topAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.leftAnchor.constraint(equalTo: barSegmentedView.leftAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.rightAnchor.constraint(equalTo: barSegmentedView.rightAnchor,constant: -5))
        barSegmentedView.addConstraint(barSegmentedControl.bottomAnchor.constraint(equalTo: barSegmentedView.bottomAnchor,constant: -5))
    }
    
    func setDelegate(ViewController vc: MovieDetailViewController) {
        bodyScrollView.delegate = vc
        infoScrollView.delegate = vc
        castCollectionView.delegate = vc
        seeScrollView.delegate = vc
        infoView.ratingCollectionView.delegate = vc
    }
}
