//
//  SearchView.swift
//  Mooviest
//
//  Created by Antonio RG on 23/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//


import UIKit

class SearchView: UIView {
    let height = UIApplication.shared.statusBarFrame.size.height
    var heightNavBar:CGFloat!
    
    var backgroundStatusView = UIView()
    var headerView = UIView()

    var movieCollectionView:UICollectionView!

    let activityView = UIActivityIndicatorView()
    
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
        
        backgroundStatusView.backgroundColor =   dark_gray.withAlphaComponent(0.5)
        headerView.backgroundColor =   mooviest_red
        headerView.clipsToBounds = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        movieCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        movieCollectionView.backgroundColor = .white
        
        activityView.activityIndicatorViewStyle = .gray
        
        addSubview(headerView)
        addSubview(movieCollectionView)
        addSubview(backgroundStatusView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(activityView.centerYAnchor.constraint(equalTo: centerYAnchor))
        addConstraint(activityView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(activityView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1))
        addConstraint(activityView.heightAnchor.constraint(equalTo: activityView.widthAnchor))
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
        addConstraint(movieCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant:1))
        addConstraint(movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-1))
        addConstraint(movieCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieCollectionView.rightAnchor.constraint(equalTo: rightAnchor))
    }
}
