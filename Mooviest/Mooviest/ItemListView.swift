//
//  ItemListView.swift
//  Mooviest
//
//  Created by Antonio RG on 11/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ItemListView: UIView {
    
    
    let heightEmptyLabel = CGFloat(30)
    let titleLabel = UILabel()
    let moreButton = UIButton(type: UIButtonType.system) as UIButton
    let emptyLabel = UILabel()
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
        titleLabel.text = "List"
        titleLabel.textColor = UIColor.darkGray.withAlphaComponent(0.8)
        titleLabel.font.withSize(20)
        
        moreButton.setTitle("More", for: .normal)
        moreButton.setTitleColor(UIColor(netHex: mooviest_red), for: .normal)
        moreButton.titleLabel?.font.withSize(20)
        
        emptyLabel.text = "Empty list"
        emptyLabel.font.withSize(heightEmptyLabel)
        emptyLabel.textColor = UIColor.darkGray.withAlphaComponent(0.8)
        emptyLabel.textAlignment = .center
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        
        movieCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        movieCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        movieCollectionView.showsHorizontalScrollIndicator = false

        addSubview(titleLabel)
        addSubview(moreButton)
        addSubview(emptyLabel)
        addSubview(movieCollectionView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5))
        addConstraint(titleLabel.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7))
        addConstraint(titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1))
        
        addConstraint(moreButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor))
        addConstraint(moreButton.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5))
        addConstraint(moreButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor))
        
        addConstraint(movieCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5))
        addConstraint(movieCollectionView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        addConstraint(emptyLabel.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(emptyLabel.centerYAnchor.constraint(equalTo: movieCollectionView.centerYAnchor))
        addConstraint(emptyLabel.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(emptyLabel.heightAnchor.constraint(equalToConstant: heightEmptyLabel))
    }
    
    func adjustFontSizeToFitHeight () {
        let heightLabel = titleLabel.frame.size.height
        titleLabel.font =  UIFont(name: titleLabel.font!.fontName, size: heightLabel)!
        moreButton.titleLabel?.font = UIFont(name: (moreButton.titleLabel?.font.fontName)!, size: heightLabel*0.9)!
    }
}
