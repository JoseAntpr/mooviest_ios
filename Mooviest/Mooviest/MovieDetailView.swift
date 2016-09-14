//
//  MovieDetailView.swift
//  Mooviest
//
//  Created by Antonio RG on 5/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {
    
    let height = UIApplication.sharedApplication().statusBarFrame.size.height
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
        self.backgroundColor = UIColor.whiteColor()
        headerLabel.text = "Header title"
        headerLabel.textColor = UIColor.whiteColor()
        headerView.backgroundColor = UIColor(netHex: mooviest_red)
        //bodyScrollView.backgroundColor = UIColor.blueColor()
        
        titleLabel.text = "body title"
        
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_gray).colorWithAlphaComponent(0.5)
        
        // Header - Blurred Image
        
        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.showsVerticalScrollIndicator = false
        
//        lineView.backgroundColor = UIColor.grayColor()
        let items = ["INFORMACIÓN", "REPARTO", "VER"]
        barSegmentedControl = UISegmentedControl(items: items)
        barSegmentedControl.selectedSegmentIndex = 0
        barSegmentedControl.tintColor = UIColor(netHex: mooviest_red)
        
        //infoView.backgroundColor = UIColor.greenColor()
        castView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        castView.backgroundColor = UIColor.redColor()
        seeView.backgroundColor = UIColor.yellowColor()
        
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

        
        addConstraint(backgroundStatusView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraintEqualToConstant(height))

        addConstraint(headerView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(headerView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(headerView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(headerView.heightAnchor.constraintEqualToAnchor(widthAnchor,multiplier: 0.5))
        
        headerView.addConstraint(headerLabel.heightAnchor.constraintEqualToConstant(35))
        headerView.addConstraint(headerLabel.leftAnchor.constraintEqualToAnchor(headerView.leftAnchor))
        headerView.addConstraint(headerLabel.widthAnchor.constraintEqualToAnchor(headerView.widthAnchor))
        headerView.addConstraint(headerLabel.bottomAnchor.constraintEqualToAnchor(headerView.bottomAnchor))
        
        headerView.addConstraint(headerBackdropImageView.leftAnchor.constraintEqualToAnchor(headerView.leftAnchor))
        headerView.addConstraint(headerBackdropImageView.widthAnchor.constraintEqualToAnchor(headerView.widthAnchor))
        headerView.addConstraint(headerBackdropImageView.topAnchor.constraintEqualToAnchor(headerView.topAnchor))
        headerView.addConstraint(headerBackdropImageView.heightAnchor.constraintEqualToAnchor(headerView.heightAnchor))
        
        addConstraint(bodyScrollView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(bodyScrollView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(bodyScrollView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(bodyScrollView.heightAnchor.constraintEqualToAnchor(heightAnchor))//430x613

        bodyScrollView.addConstraint(coverImageView.topAnchor.constraintEqualToAnchor(bodyScrollView.topAnchor,constant: 70))
        bodyScrollView.addConstraint(coverImageView.leftAnchor.constraintEqualToAnchor(bodyScrollView.leftAnchor, constant: 20))
        bodyScrollView.addConstraint(coverImageView.widthAnchor.constraintEqualToAnchor(bodyScrollView.widthAnchor, multiplier: 0.4))
        bodyScrollView.addConstraint(coverImageView.heightAnchor.constraintEqualToAnchor(coverImageView.widthAnchor, multiplier: 1.4))
        
        bodyScrollView.addConstraint(titleLabel.topAnchor.constraintEqualToAnchor(coverImageView.topAnchor,constant: 5))
        bodyScrollView.addConstraint(titleLabel.leftAnchor.constraintEqualToAnchor(bodyScrollView.leftAnchor, constant: 10))
        bodyScrollView.addConstraint(titleLabel.heightAnchor.constraintEqualToConstant(20))
        bodyScrollView.addConstraint(titleLabel.widthAnchor.constraintEqualToConstant(100))
        
        bodyScrollView.addConstraint(infoView.topAnchor.constraintEqualToAnchor(coverImageView.bottomAnchor,constant: 60))
        bodyScrollView.addConstraint(infoView.leftAnchor.constraintEqualToAnchor(bodyScrollView.leftAnchor))
        bodyScrollView.addConstraint(infoView.widthAnchor.constraintEqualToAnchor(bodyScrollView.widthAnchor))
        bodyScrollView.addConstraint(infoView.heightAnchor.constraintEqualToConstant(800))

        bodyScrollView.addConstraint(castView.topAnchor.constraintEqualToAnchor(coverImageView.bottomAnchor,constant: 60))
        bodyScrollView.addConstraint(castView.leftAnchor.constraintEqualToAnchor(bodyScrollView.leftAnchor,constant: 5))
        bodyScrollView.addConstraint(castView.widthAnchor.constraintEqualToAnchor(bodyScrollView.widthAnchor,constant: -10))
        bodyScrollView.addConstraint(castView.heightAnchor.constraintEqualToConstant(800))

        bodyScrollView.addConstraint(seeView.topAnchor.constraintEqualToAnchor(coverImageView.bottomAnchor,constant: 60))
        bodyScrollView.addConstraint(seeView.leftAnchor.constraintEqualToAnchor(bodyScrollView.leftAnchor,constant: 5))
        bodyScrollView.addConstraint(seeView.widthAnchor.constraintEqualToAnchor(bodyScrollView.widthAnchor,constant: -10))
        bodyScrollView.addConstraint(seeView.heightAnchor.constraintEqualToConstant(800))

        addConstraint(barSegmentedView.topAnchor.constraintEqualToAnchor(coverImageView.bottomAnchor,constant: 10))
        addConstraint(barSegmentedView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(barSegmentedView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(barSegmentedView.heightAnchor.constraintEqualToConstant(40))//430x613
        
        barSegmentedView.addConstraint(barSegmentedControl.topAnchor.constraintEqualToAnchor(barSegmentedView.topAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.leftAnchor.constraintEqualToAnchor(barSegmentedView.leftAnchor,constant: 5))
        barSegmentedView.addConstraint(barSegmentedControl.rightAnchor.constraintEqualToAnchor(barSegmentedView.rightAnchor,constant: -5))
        barSegmentedView.addConstraint(barSegmentedControl.bottomAnchor.constraintEqualToAnchor(barSegmentedView.bottomAnchor,constant: -5))
        
//        barSegmentedView.addConstraint(lineView.topAnchor.constraintEqualToAnchor(barSegmentedView.bottomAnchor,constant: 5))
//        barSegmentedView.addConstraint(lineView.leftAnchor.constraintEqualToAnchor(barSegmentedView.leftAnchor))
//        barSegmentedView.addConstraint(lineView.rightAnchor.constraintEqualToAnchor(barSegmentedView.rightAnchor,constant: -5))
//        barSegmentedView.addConstraint(lineView.heightAnchor.constraintEqualToConstant(0.5))
    }
    
    
}
