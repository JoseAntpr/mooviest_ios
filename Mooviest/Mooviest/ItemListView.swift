//
//  ItemListView.swift
//  Mooviest
//
//  Created by Antonio RG on 11/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ItemListView: UIView {
    
    let percentTitle = CGFloat(0.2)
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
        titleLabel.text = NSLocalizedString("textTitleLabelList", comment: "Text of titleLabelList")
        titleLabel.textColor = UIColor.darkGray.withAlphaComponent(0.8)
        titleLabel.font.withSize(20)
        
        let title = NSLocalizedString("titleMoreButton", comment: "Title of moreButton")
        moreButton.setTitle(title, for: .normal)
        moreButton.setTitleColor(mooviest_red, for: .normal)
        moreButton.titleLabel?.font.withSize(20)
        
        emptyLabel.text = NSLocalizedString("textEmptyLabel", comment: "Text of emptyLabelList")
        emptyLabel.font.withSize(heightEmptyLabel)
        emptyLabel.textColor = UIColor.darkGray.withAlphaComponent(0.8)
        emptyLabel.textAlignment = .center
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        movieCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:layout)
        movieCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0)
        movieCollectionView.showsHorizontalScrollIndicator = false

        
        addSubview(emptyLabel)
        addSubview(movieCollectionView)
        addSubview(titleLabel)
        addSubview(moreButton)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5))
        addConstraint(titleLabel.bottomAnchor.constraint(equalTo: movieCollectionView.topAnchor))
        addConstraint(titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7))
        addConstraint(titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: percentTitle*0.9))
        
        addConstraint(moreButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor))
        addConstraint(moreButton.bottomAnchor.constraint(equalTo: movieCollectionView.topAnchor))
        addConstraint(moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5))
        addConstraint(moreButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor))
        
        addConstraint(movieCollectionView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5))
        addConstraint(movieCollectionView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(movieCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1-percentTitle))
        
        addConstraint(emptyLabel.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(emptyLabel.centerYAnchor.constraint(equalTo: movieCollectionView.centerYAnchor))
        addConstraint(emptyLabel.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(emptyLabel.heightAnchor.constraint(equalToConstant: heightEmptyLabel))
    }
    
    func adjustFontSizeToFitHeight () {
        let heightLabel = titleLabel.frame.size.height*0.5
        if heightLabel > 0 {
            titleLabel.font =  UIFont(name: titleLabel.font!.fontName, size: heightLabel)!
            moreButton.titleLabel?.font = UIFont(name: (moreButton.titleLabel?.font.fontName)!, size: heightLabel*0.9)!
        }
    }
}
