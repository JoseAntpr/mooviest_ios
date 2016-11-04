//
//  ListView.swift
//  Mooviest
//
//  Created by Antonio RG on 12/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ListView: UIView {
    let height = UIApplication.shared.statusBarFrame.size.height
    var heightNavBar:CGFloat!
    let margin = CGFloat(2)
    var backgroundStatusView = UIView()
    var headerView = UIView()
    let lineView = UIView()
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
        self.backgroundColor = .white
        
        backgroundStatusView.backgroundColor =   UIColor.white.withAlphaComponent(0.2)
        headerView.backgroundColor =   .white
        headerView.clipsToBounds = true
        
        lineView.backgroundColor = UIColor.lightGray
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = margin/2
        layout.minimumLineSpacing = margin
        
        movieCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        movieCollectionView.backgroundColor = .white

        addSubview(movieCollectionView)
        addSubview(headerView)
        addSubview(lineView)
        addSubview(backgroundStatusView)
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
        addConstraint(lineView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(lineView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(lineView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(lineView.heightAnchor.constraint(equalToConstant: 0.5))
        
        addConstraint(movieCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: margin))
        addConstraint(movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin))
        addConstraint(movieCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieCollectionView.rightAnchor.constraint(equalTo: rightAnchor))        
    }
}

