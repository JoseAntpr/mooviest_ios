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
    var coverImageView = CoverImageView()
    var titleLabel = UILabel()

//    var barSegmentedView = UIView()
//    var lineView = UIView()
//    var barSegmentedControl = UISegmentedControl()
    
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
        coverImageView.kf_setImageWithURL(NSURL(string:  "https://img.tviso.com/ES/poster/w200/24/11/241162d09013bc00b7da919781c95b5b.jpg"))
        coverImageView.contentMode = UIViewContentMode.ScaleToFill
        coverImageView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.9).CGColor
        coverImageView.layer.borderWidth = 1.8
        coverImageView.layer.cornerRadius = 5
        coverImageView.layer.masksToBounds = true
        titleLabel.text = "body title"
        
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_red).colorWithAlphaComponent(0.5)
        
        // Header - Blurred Image
        headerBackdropImageView.kf_setImageWithURL(NSURL(string: "https://img.tviso.com/ES/backdrop/w300/24/11/241162d09013bc00b7da919781c95b5b.jpg"))
        headerBackdropImageView.contentMode = UIViewContentMode.ScaleToFill
        bodyScrollView.showsHorizontalScrollIndicator = false
        bodyScrollView.showsVerticalScrollIndicator = false
        
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerBackdropImageView)
        bodyScrollView.addSubview(coverImageView)
        bodyScrollView.addSubview(titleLabel)
        
        addSubview(headerView)
        addSubview(bodyScrollView)
        addSubview(backgroundStatusView)
    }
    
    func setupConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerBackdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraintEqualToConstant(height))

        
        addConstraint(headerView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(headerView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(headerView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(headerView.heightAnchor.constraintEqualToAnchor(widthAnchor,multiplier: 0.3))
        
        headerView.addConstraint(headerLabel.heightAnchor.constraintEqualToConstant(40))
        headerView.addConstraint(headerLabel.leftAnchor.constraintEqualToAnchor(headerView.leftAnchor))
        headerView.addConstraint(headerLabel.widthAnchor.constraintEqualToAnchor(headerView.widthAnchor))
        headerView.addConstraint(headerLabel.bottomAnchor.constraintEqualToAnchor(headerView.bottomAnchor))
        
        headerView.addConstraint(headerBackdropImageView.heightAnchor.constraintEqualToAnchor(headerView.heightAnchor))
        headerView.addConstraint(headerBackdropImageView.leftAnchor.constraintEqualToAnchor(headerView.leftAnchor))
        headerView.addConstraint(headerBackdropImageView.widthAnchor.constraintEqualToAnchor(headerView.widthAnchor))
        headerView.addConstraint(headerBackdropImageView.topAnchor.constraintEqualToAnchor(headerView.topAnchor))
        
        addConstraint(bodyScrollView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(bodyScrollView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(bodyScrollView.rightAnchor.constraintEqualToAnchor(rightAnchor))
        addConstraint(bodyScrollView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))//430x613

        bodyScrollView.addConstraint(coverImageView.topAnchor.constraintEqualToAnchor(bodyScrollView.topAnchor,constant: 30))
        bodyScrollView.addConstraint(coverImageView.leftAnchor.constraintEqualToAnchor(bodyScrollView.leftAnchor, constant: 20))
        bodyScrollView.addConstraint(coverImageView.widthAnchor.constraintEqualToAnchor(bodyScrollView.widthAnchor, multiplier: 0.3))
        bodyScrollView.addConstraint(coverImageView.heightAnchor.constraintEqualToAnchor(coverImageView.widthAnchor, multiplier: 1.4))
        
        bodyScrollView.addConstraint(titleLabel.topAnchor.constraintEqualToAnchor(coverImageView.bottomAnchor,constant: 5))
        bodyScrollView.addConstraint(titleLabel.leftAnchor.constraintEqualToAnchor(bodyScrollView.leftAnchor, constant: 10))
        bodyScrollView.addConstraint(titleLabel.heightAnchor.constraintEqualToConstant(20))
        bodyScrollView.addConstraint(titleLabel.widthAnchor.constraintEqualToConstant(100))
    }
    
    
}
