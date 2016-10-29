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

//    let searchBar = UISearchBar()
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
//        searchBar.barTintColor = UIColor(netHex: mooviest_red)
        
        backgroundStatusView.backgroundColor =   dark_gray.withAlphaComponent(0.5)
        headerView.backgroundColor =   mooviest_red
        headerView.clipsToBounds = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        movieCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        movieCollectionView.backgroundColor = .white
        
        
        addSubview(headerView)
        addSubview(movieCollectionView)
//        addSubview(searchBar)
        addSubview(backgroundStatusView)
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
//        addConstraint(searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor))
//        addConstraint(searchBar.leftAnchor.constraint(equalTo: leftAnchor))
//        addConstraint(searchBar.rightAnchor.constraint(equalTo: rightAnchor))
//        addConstraint(searchBar.heightAnchor.constraint(equalToConstant: 40))
        
        addConstraint(movieCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant:1))
        addConstraint(movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-1))
        addConstraint(movieCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieCollectionView.rightAnchor.constraint(equalTo: rightAnchor))
    }
}
