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
    var backgroundStatusView = UIView()
    var headerView = UIView()
    var headerLabel = UILabel()
    var headerBackdropImageView = UIImageView()
    var bodyScrollView = UIScrollView()
    var coverImageView = UIImageView()
    var titleLabel = UILabel()
    
    var barSegmentedView = UIView()
    //    var lineView = UIView()
    var barSegmentedControl: UISegmentedControl!
    var infoView = InfoMovieView()
    var castView:UICollectionView!
    var seeView = UIView()
    
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
        headerLabel.text = "Header title"
        headerLabel.textColor = UIColor.white
        headerView.backgroundColor = UIColor(netHex: mooviest_red)
        //bodyScrollView.backgroundColor = UIColor.blueColor()
        
        titleLabel.text = "body title"
        
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_gray).withAlphaComponent(0.5)
        
        // Header - Blurred Image
        
        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.showsVerticalScrollIndicator = false
        
        //        lineView.backgroundColor = UIColor.grayColor()
        let items = ["INFORMACIÓN", "REPARTO", "VER"]
        barSegmentedControl = UISegmentedControl(items: items)
        barSegmentedControl.selectedSegmentIndex = 0
        barSegmentedControl.tintColor = UIColor(netHex: mooviest_red)
        
        //infoView.backgroundColor = UIColor.greenColor()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        castView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        castView.backgroundColor = UIColor.white
        seeView.backgroundColor = UIColor.yellow
        
        headerView.clipsToBounds = true
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerBackdropImageView)
        
        bodyScrollView.addSubview(titleLabel)
        bodyScrollView.addSubview(coverImageView)
        bodyScrollView.addSubview(seeView)
        bodyScrollView.addSubview(castView)
        bodyScrollView.addSubview(infoView)
        
        barSegmentedView.addSubview(barSegmentedControl)
        //        barSegmentedView.addSubview(lineView)
        
        
        addSubview(headerView)
        addSubview(bodyScrollView)
        addSubview(backgroundStatusView)
        addSubview(barSegmentedView)
    }
    
    func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerBackdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedView.translatesAutoresizingMaskIntoConstraints = false
        barSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        //        lineView.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        castView.translatesAutoresizingMaskIntoConstraints = false
        seeView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalTo: widthAnchor,multiplier: 0.5))
        
        headerView.addConstraint(headerLabel.heightAnchor.constraint(equalToConstant: 35))
        headerView.addConstraint(headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor))
        headerView.addConstraint(headerLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor))
        headerView.addConstraint(headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor))
        
        headerView.addConstraint(headerBackdropImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor))
        headerView.addConstraint(headerBackdropImageView.widthAnchor.constraint(equalTo: headerView.widthAnchor))
        headerView.addConstraint(headerBackdropImageView.topAnchor.constraint(equalTo: headerView.topAnchor))
        headerView.addConstraint(headerBackdropImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor))
        
        addConstraint(bodyScrollView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(bodyScrollView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(bodyScrollView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(bodyScrollView.heightAnchor.constraint(equalTo: heightAnchor))
        
        bodyScrollView.addConstraint(coverImageView.topAnchor.constraint(equalTo: bodyScrollView.topAnchor,constant: 70))
        bodyScrollView.addConstraint(coverImageView.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor, constant: 20))
        bodyScrollView.addConstraint(coverImageView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor, multiplier: 0.4))
        bodyScrollView.addConstraint(coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 1.4))
        
        bodyScrollView.addConstraint(titleLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor,constant: 5))
        bodyScrollView.addConstraint(titleLabel.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor, constant: 10))
        bodyScrollView.addConstraint(titleLabel.heightAnchor.constraint(equalToConstant: 20))
        bodyScrollView.addConstraint(titleLabel.widthAnchor.constraint(equalToConstant: 100))
        
        bodyScrollView.addConstraint(infoView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor,constant: 50))
        bodyScrollView.addConstraint(infoView.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor))
        bodyScrollView.addConstraint(infoView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor))
        bodyScrollView.addConstraint(infoView.heightAnchor.constraint(equalTo: bodyScrollView.heightAnchor))
        
        bodyScrollView.addConstraint(castView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor,constant: 50))
        bodyScrollView.addConstraint(castView.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor,constant: 5))
        bodyScrollView.addConstraint(castView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor,constant: -10))
        bodyScrollView.addConstraint(castView.heightAnchor.constraint(equalTo: bodyScrollView.heightAnchor,constant: -145))
        
        
        bodyScrollView.addConstraint(seeView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor,constant: 50))
        bodyScrollView.addConstraint(seeView.leftAnchor.constraint(equalTo: bodyScrollView.leftAnchor,constant: 5))
        bodyScrollView.addConstraint(seeView.widthAnchor.constraint(equalTo: bodyScrollView.widthAnchor,constant: -10))
        bodyScrollView.addConstraint(seeView.heightAnchor.constraint(equalTo: bodyScrollView.heightAnchor, constant: -145))
        
        addConstraint(barSegmentedView.topAnchor.constraint(equalTo: coverImageView.bottomAnchor,constant: 10))
        addConstraint(barSegmentedView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(barSegmentedView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(barSegmentedView.heightAnchor.constraint(equalToConstant: 40))//430x613
        
        barSegmentedView.addConstraint(barSegmentedControl.topAnchor.constraint(equalTo: barSegmentedView.topAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.leftAnchor.constraint(equalTo: barSegmentedView.leftAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.rightAnchor.constraint(equalTo: barSegmentedView.rightAnchor,constant: -5))
        barSegmentedView.addConstraint(barSegmentedControl.bottomAnchor.constraint(equalTo: barSegmentedView.bottomAnchor,constant: -5))
        
        //        barSegmentedView.addConstraint(lineView.topAnchor.constraintEqualToAnchor(barSegmentedView.bottomAnchor,constant: 5))
        //        barSegmentedView.addConstraint(lineView.leftAnchor.constraintEqualToAnchor(barSegmentedView.leftAnchor))
        //        barSegmentedView.addConstraint(lineView.rightAnchor.constraintEqualToAnchor(barSegmentedView.rightAnchor,constant: -5))
        //        barSegmentedView.addConstraint(lineView.heightAnchor.constraintEqualToConstant(0.5))
    }
    
    
}
