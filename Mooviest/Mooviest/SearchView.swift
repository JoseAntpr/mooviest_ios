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
    var headerBackgroundView = UIView()
    var headerView = UIView()
    var searchBar = UISearchBar()
    var movieCollectionView:UICollectionView!

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
        
        backgroundStatusView.backgroundColor =  UIColor.white.withAlphaComponent(0.5)
        headerBackgroundView.backgroundColor =  UIColor.lightGray.withAlphaComponent(0.2)
        
        headerView.backgroundColor = .white
        headerView.clipsToBounds = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        movieCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        movieCollectionView.backgroundColor = .white
        
        
        addSubview(movieCollectionView)        
        addSubview(headerView)
        addSubview(headerBackgroundView)
        addSubview(searchBar)
        addSubview(backgroundStatusView)
    }
    
    func setupConstraints() {
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
        addConstraint(headerBackgroundView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerBackgroundView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerBackgroundView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerBackgroundView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
        addConstraint(searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(searchBar.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(searchBar.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(searchBar.heightAnchor.constraint(equalToConstant: heightNavBar))
        
        addConstraint(movieCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant:1))
        addConstraint(movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-1))
        addConstraint(movieCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieCollectionView.rightAnchor.constraint(equalTo: rightAnchor))
    }
}
