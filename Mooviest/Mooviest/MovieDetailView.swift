//
//  MovieDetailView.swift
//  Mooviest
//
//  Created by Antonio RG on 5/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import KCFloatingActionButton

class MovieDetailView: UIView {
    
    let height = UIApplication.shared.statusBarFrame.size.height
    let heightSegmentedView = CGFloat(40)
    let spaceBottomBarButtons = CGFloat(5)
    let porcentWidthButton = CGFloat(0.16)
    let porcentWidthBarButtons = CGFloat(0.86)
    var heightNavBar:CGFloat!
    
    let backgroundStatusView = UIView()
    
    let headerView = UIView()
    let headerBackdropImageView = UIImageView()
    
    let bodyScrollView = UIScrollView()
    
    var profileCardView = UIView()
    let coverImageView = UIImageView()
    let captionMovieView = CaptionMovieView()
    
    let infoView = InfoMovieView()
    var castCollectionView:UICollectionView!
    
    let seeView = UIView()
    let seeInfoLabel = UILabel()
    
    let barSegmentedBackground = UIView()
    let barSegmentedView = UIView()
    var barSegmentedControl: UISegmentedControl!
    
    let space1View = UIView ()
    let space2View = UIView ()
    let space3View = UIView ()
    
    let fab = KCFloatingActionButton()
    let seenItem = KCFloatingActionButtonItem()
    let wacthItem = KCFloatingActionButtonItem()
    let favouriteItem = KCFloatingActionButtonItem()
    let blackItem = KCFloatingActionButtonItem()
    
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
        
        backgroundStatusView.backgroundColor = dark_gray.withAlphaComponent(0.5)
        headerView.backgroundColor = mooviest_red

        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.showsVerticalScrollIndicator = false
        
        let items = ["INFORMACIÓN", "REPARTO", "VER"]
        barSegmentedControl = UISegmentedControl(items: items)
        barSegmentedControl.selectedSegmentIndex = 0
        barSegmentedControl.tintColor = mooviest_red
        barSegmentedControl.layer.cornerRadius = 5
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        castCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        castCollectionView.backgroundColor = UIColor.white
        
        headerView.clipsToBounds = true
        
        
        
        seeInfoLabel.text = "Proximamente..."
        seeInfoLabel.textColor = .darkGray
        seeInfoLabel.font = UIFont.boldSystemFont(ofSize: seeInfoLabel.font.pointSize)
        seeInfoLabel.textAlignment = .center
        
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
 
        
        headerView.addSubview(blurEffectView)
        headerView.addSubview(headerBackdropImageView)
        profileCardView.addSubview(captionMovieView)
        profileCardView.addSubview(coverImageView)
        
        barSegmentedView.backgroundColor = .white
        
        
        fab.animationSpeed = 0.01
        fab.buttonColor = mooviest_red
        fab.plusColor = .white
        
        seenItem.buttonColor = .lightGray
        seenItem.icon = UIImage(named:"eye")?.withRenderingMode(.alwaysTemplate)
        seenItem.tintColor = .white
        seenItem.title = "Vista"
        
        wacthItem.buttonColor = .lightGray
        wacthItem.icon = UIImage(named:"bookmark")?.withRenderingMode(.alwaysTemplate)
        wacthItem.tintColor = .white
        wacthItem.title = "Pendiente"
        
        favouriteItem.buttonColor = .lightGray
        favouriteItem.icon = UIImage(named:"star")?.withRenderingMode(.alwaysTemplate)
        favouriteItem.tintColor = .white
        favouriteItem.title = "Favorita"
        
        blackItem.buttonColor = .lightGray
        blackItem.icon = UIImage(named:"clear")?.withRenderingMode(.alwaysTemplate)
        blackItem.tintColor = .white
        blackItem.title = "No me interesa"
        
        barSegmentedBackground.backgroundColor = .white
        
        fab.addItem(item: seenItem)
        fab.addItem(item: wacthItem)
        fab.addItem(item: favouriteItem)
        fab.addItem(item: blackItem)
        
        seeView.addSubview(seeInfoLabel)
        
        barSegmentedView.addSubview(barSegmentedBackground)
        barSegmentedView.addSubview(barSegmentedControl)
        

        addSubview(headerView)
        
        addSubview(seeView)
        addSubview(castCollectionView)
        addSubview(infoView)
        addSubview(profileCardView)
        addSubview(bodyScrollView)
        addSubview(backgroundStatusView)
        addSubview(barSegmentedView)
        addSubview(fab)
        
    }
    
    func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        headerBackdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        castCollectionView.translatesAutoresizingMaskIntoConstraints = false
        seeView.translatesAutoresizingMaskIntoConstraints = false
        profileCardView.translatesAutoresizingMaskIntoConstraints = false
        space1View.translatesAutoresizingMaskIntoConstraints = false
        space2View.translatesAutoresizingMaskIntoConstraints = false
        space3View.translatesAutoresizingMaskIntoConstraints = false
        captionMovieView.translatesAutoresizingMaskIntoConstraints = false
        seeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedBackground.translatesAutoresizingMaskIntoConstraints = false
        
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
        let margin = CGFloat(4)
        profileCardView.addConstraint(captionMovieView.topAnchor.constraint(equalTo: profileCardView.topAnchor, constant: margin))
        profileCardView.addConstraint(captionMovieView.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: margin))
        profileCardView.addConstraint(captionMovieView.rightAnchor.constraint(equalTo: profileCardView.rightAnchor, constant: -margin))
        profileCardView.addConstraint(captionMovieView.bottomAnchor.constraint(equalTo: profileCardView.bottomAnchor, constant: -margin))
        
        addConstraint(bodyScrollView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(bodyScrollView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(bodyScrollView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(bodyScrollView.heightAnchor.constraint(equalTo: heightAnchor))
        
        let heightTabsView = -heightNavBar-height-heightSegmentedView
        
        addConstraint(infoView.topAnchor.constraint(equalTo: barSegmentedView.bottomAnchor))
        addConstraint(infoView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(infoView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(infoView.heightAnchor.constraint(equalTo: heightAnchor,constant: heightTabsView))
        
        addConstraint(castCollectionView.topAnchor.constraint(equalTo: barSegmentedView.bottomAnchor))
        addConstraint(castCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(castCollectionView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(castCollectionView.heightAnchor.constraint(equalTo: heightAnchor,constant: heightTabsView))
        
        addConstraint(seeView.topAnchor.constraint(equalTo: barSegmentedView.bottomAnchor))
        addConstraint(seeView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(seeView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(seeView.heightAnchor.constraint(equalTo: heightAnchor,constant: heightTabsView))
        
        seeView.addConstraint(seeInfoLabel.topAnchor.constraint(equalTo: seeView.topAnchor, constant:50))
        seeView.addConstraint(seeInfoLabel.leftAnchor.constraint(equalTo: seeView.leftAnchor))
        seeView.addConstraint(seeInfoLabel.widthAnchor.constraint(equalTo: seeView.widthAnchor))
        seeView.addConstraint(seeInfoLabel.heightAnchor.constraint(equalTo: seeView.heightAnchor, multiplier:0.1))
        
        addConstraint(barSegmentedView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor))
        addConstraint(barSegmentedView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(barSegmentedView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(barSegmentedView.heightAnchor.constraint(equalToConstant: heightSegmentedView))
        
        barSegmentedView.addConstraint(barSegmentedControl.topAnchor.constraint(equalTo: barSegmentedView.topAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.leftAnchor.constraint(equalTo: barSegmentedView.leftAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.rightAnchor.constraint(equalTo: barSegmentedView.rightAnchor,constant: -5))
        barSegmentedView.addConstraint(barSegmentedControl.bottomAnchor.constraint(equalTo: barSegmentedView.bottomAnchor,constant: -5))
        
        barSegmentedView.addConstraint(barSegmentedBackground.topAnchor.constraint(equalTo: barSegmentedView.topAnchor))
        barSegmentedView.addConstraint(barSegmentedBackground.leftAnchor.constraint(equalTo: barSegmentedView.leftAnchor))
        barSegmentedView.addConstraint(barSegmentedBackground.rightAnchor.constraint(equalTo: barSegmentedView.rightAnchor))
        barSegmentedView.addConstraint(barSegmentedBackground.bottomAnchor.constraint(equalTo: barSegmentedView.bottomAnchor))
    }
    
    func setDelegate(ViewController vc: MovieDetailViewController) {
        bodyScrollView.delegate = vc
        castCollectionView.delegate = vc
        infoView.ratingCollectionView.delegate = vc
    }
    
    func adjustFontSizeToFitHeight () {
        captionMovieView.adjustFontSizeToFitHeight()
    }
    
    func setColors(backgroundColor: UIColor, tintColor:UIColor) {
        
        headerView.backgroundColor = backgroundColor
        barSegmentedControl.tintColor = tintColor
        barSegmentedBackground.backgroundColor = backgroundColor
        profileCardView.backgroundColor = backgroundColor
        captionMovieView.setColors(backgroundColor: backgroundColor, tintColor: tintColor)
    }
    
}
