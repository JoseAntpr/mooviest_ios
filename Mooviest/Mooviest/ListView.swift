//
//  ListView.swift
//  Mooviest
//
//  Created by Antonio RG on 12/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ListView: UIView {
    var movieCollectionView:UICollectionView!
    
    init() {
        super.init(frame: CGRect.zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        movieCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        movieCollectionView.backgroundColor = .white

        addSubview(movieCollectionView)
    }
    
    func setupConstraints() {
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false

        addConstraint(movieCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieCollectionView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(movieCollectionView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor))
    }
}

