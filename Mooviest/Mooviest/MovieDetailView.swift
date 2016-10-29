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
    let spaceBottomBarButtons = CGFloat(5)
    let porcentWidthButton = CGFloat(0.16)
    let porcentWidthBarButtons = CGFloat(0.86)
    var heightNavBar:CGFloat!
    
    let backgroundStatusView = UIView()
    
    let headerView = UIView()
    let headerBackdropImageView = UIImageView()
    
    let bodyScrollView = UIScrollView()
    
//    let tabsView = UIView()
    var profileCardView = UIView()
    let coverImageView = UIImageView()
    let captionMovieView = CaptionMovieView()
    
    let infoView = InfoMovieView()
    var castCollectionView:UICollectionView!
    
    let seeView = UIView()
    let seeInfoLabel = UILabel()
    
    let barSegmentedView = UIView()
    var barSegmentedControl: UISegmentedControl!
    
    var panelButtonView = UIView()
    var closedButton = UIButton(type: UIButtonType.system) as UIButton
    var clockButton = UIButton(type: UIButtonType.system) as UIButton
    var eyeButton = UIButton(type: UIButtonType.system) as UIButton
    var heartButton = UIButton(type: UIButtonType.system) as UIButton
    
    let space1View = UIView ()
    let space2View = UIView ()
    let space3View = UIView ()
    
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
        
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_gray).withAlphaComponent(0.5)
        headerView.backgroundColor = UIColor(netHex: mooviest_red)

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
        
        headerView.clipsToBounds = true
        
        closedButton.setImage( UIImage(named: "clear"), for: UIControlState())
        closedButton.tintColor = .black
        closedButton.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        clockButton.setImage( UIImage(named: "bookmark"), for: UIControlState())
        clockButton.tintColor = UIColor(netHex: watchlist_color)
        clockButton.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        eyeButton.setImage( UIImage(named: "eye"), for: UIControlState())
        eyeButton.tintColor = UIColor(netHex: seen_color)
        eyeButton.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        heartButton.setImage( UIImage(named: "star"), for: UIControlState())
        heartButton.tintColor = UIColor(netHex: favourite_color)
        heartButton.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        closedButton.tintColor = UIColor.darkGray.withAlphaComponent(0.5)
        clockButton.tintColor = UIColor.darkGray.withAlphaComponent(0.5)
        eyeButton.tintColor = UIColor.darkGray.withAlphaComponent(0.5)
        heartButton.tintColor = UIColor.darkGray.withAlphaComponent(0.5)
        
        seeInfoLabel.text = "Proximamente se podrá visualizar..."
        seeInfoLabel.textColor = .darkGray
        seeInfoLabel.font = UIFont.boldSystemFont(ofSize: seeInfoLabel.font.pointSize)
        seeInfoLabel.textAlignment = .center
        
        headerView.addSubview(headerBackdropImageView)
        profileCardView.addSubview(captionMovieView)
        profileCardView.addSubview(coverImageView)
        
        barSegmentedView.backgroundColor = .white
        
        
        seeView.addSubview(seeInfoLabel)
        
        barSegmentedView.addSubview(barSegmentedControl)

        panelButtonView.addSubview(closedButton)
        panelButtonView.addSubview(clockButton)
        panelButtonView.addSubview(eyeButton)
        panelButtonView.addSubview(heartButton)
        panelButtonView.addSubview(space1View)
        panelButtonView.addSubview(space2View)
        panelButtonView.addSubview(space3View)
        
        
        addSubview(headerView)
        
        
        addSubview(seeView)
        addSubview(castCollectionView)
        addSubview(infoView)
        addSubview(profileCardView)
        addSubview(bodyScrollView)
        addSubview(panelButtonView)
        addSubview(backgroundStatusView)
        addSubview(barSegmentedView)
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
        panelButtonView.translatesAutoresizingMaskIntoConstraints = false
        closedButton.translatesAutoresizingMaskIntoConstraints = false
        clockButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        space1View.translatesAutoresizingMaskIntoConstraints = false
        space2View.translatesAutoresizingMaskIntoConstraints = false
        space3View.translatesAutoresizingMaskIntoConstraints = false
        captionMovieView.translatesAutoresizingMaskIntoConstraints = false
        seeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func setDelegate(ViewController vc: MovieDetailViewController) {
        bodyScrollView.delegate = vc
        castCollectionView.delegate = vc
        infoView.ratingCollectionView.delegate = vc
    }
    
    func adjustFontSizeToFitHeight () {
        let widthButton = closedButton.bounds.size.width
        
        closedButton.layer.cornerRadius = 0.5 * widthButton
        closedButton.clipsToBounds = true
        clockButton.layer.cornerRadius = 0.5 * widthButton
        clockButton.clipsToBounds = true
        heartButton.layer.cornerRadius = 0.5 * widthButton
        heartButton.clipsToBounds = true
        eyeButton.layer.cornerRadius = 0.5 * widthButton
        eyeButton.clipsToBounds = true

        captionMovieView.adjustFontSizeToFitHeight()
        
    }
}
