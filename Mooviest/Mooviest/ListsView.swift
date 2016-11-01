//
//  ListsView.swift
//  Mooviest
//
//  Created by Antonio RG on 11/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ListsView: UIView {
    let height = UIApplication.shared.statusBarFrame.size.height
    let width = UIApplication.shared.statusBarFrame.size.width
    var heightItemListView:CGFloat!
    let margin:CGFloat = 8
    var backgroundStatusView = UIView()
    
    var heightNavBar:CGFloat!
    var headerView = UIView()

    let listsScrollView = UIScrollView()
    
    let watchListViewCell = ItemListView()
    let favouriteListViewCell = ItemListView()
    let seenListViewCell = ItemListView()
    let blackListViewCell = ItemListView()
    
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
        self.backgroundColor = .white
        
        backgroundStatusView.backgroundColor =   dark_gray.withAlphaComponent(0.5)
        headerView.backgroundColor =   mooviest_red
        headerView.clipsToBounds = true
        
        watchListViewCell.titleLabel.text = "Watch list"
        favouriteListViewCell.titleLabel.text = "Favourite list"
        seenListViewCell.titleLabel.text = "Seen list"
        blackListViewCell.titleLabel.text = "Black list"
        
        heightItemListView = width*0.6
        
        listsScrollView.contentSize.height = heightItemListView*4 + margin*5
        
        activityView.activityIndicatorViewStyle = .white
        activityView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        activityView.layer.cornerRadius = 5
        activityView.layer.masksToBounds = true
        
        listsScrollView.addSubview(watchListViewCell)
        listsScrollView.addSubview(favouriteListViewCell)
        listsScrollView.addSubview(seenListViewCell)
        listsScrollView.addSubview(blackListViewCell)
        
        addSubview(listsScrollView)
        addSubview(headerView)
        addSubview(backgroundStatusView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        listsScrollView.translatesAutoresizingMaskIntoConstraints = false
        watchListViewCell.translatesAutoresizingMaskIntoConstraints = false
        favouriteListViewCell.translatesAutoresizingMaskIntoConstraints = false
        seenListViewCell.translatesAutoresizingMaskIntoConstraints = false
        blackListViewCell.translatesAutoresizingMaskIntoConstraints = false
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
        
        addConstraint(listsScrollView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(listsScrollView.bottomAnchor.constraint(equalTo: bottomAnchor))
        addConstraint(listsScrollView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(listsScrollView.rightAnchor.constraint(equalTo: rightAnchor))
        
        listsScrollView.addConstraint(watchListViewCell.topAnchor.constraint(equalTo: listsScrollView.topAnchor, constant: margin))
        listsScrollView.addConstraint(watchListViewCell.centerXAnchor.constraint(equalTo: listsScrollView.centerXAnchor))
        listsScrollView.addConstraint(watchListViewCell.widthAnchor.constraint(equalTo: listsScrollView.widthAnchor, multiplier: 0.95))
        listsScrollView.addConstraint(watchListViewCell.heightAnchor.constraint(equalToConstant: heightItemListView))
        
        listsScrollView.addConstraint(favouriteListViewCell.topAnchor.constraint(equalTo: watchListViewCell.bottomAnchor, constant: margin))
        listsScrollView.addConstraint(favouriteListViewCell.centerXAnchor.constraint(equalTo: listsScrollView.centerXAnchor))
        listsScrollView.addConstraint(favouriteListViewCell.widthAnchor.constraint(equalTo: watchListViewCell.widthAnchor))
        listsScrollView.addConstraint(favouriteListViewCell.heightAnchor.constraint(equalTo: watchListViewCell.heightAnchor))
        
        listsScrollView.addConstraint(seenListViewCell.topAnchor.constraint(equalTo: favouriteListViewCell.bottomAnchor, constant: margin))
        listsScrollView.addConstraint(seenListViewCell.centerXAnchor.constraint(equalTo: listsScrollView.centerXAnchor))
        listsScrollView.addConstraint(seenListViewCell.widthAnchor.constraint(equalTo: watchListViewCell.widthAnchor))
        listsScrollView.addConstraint(seenListViewCell.heightAnchor.constraint(equalTo: watchListViewCell.heightAnchor))
        
        listsScrollView.addConstraint(blackListViewCell.topAnchor.constraint(equalTo: seenListViewCell.bottomAnchor, constant: margin))
        listsScrollView.addConstraint(blackListViewCell.centerXAnchor.constraint(equalTo: listsScrollView.centerXAnchor))
        listsScrollView.addConstraint(blackListViewCell.widthAnchor.constraint(equalTo: watchListViewCell.widthAnchor))
        listsScrollView.addConstraint(blackListViewCell.heightAnchor.constraint(equalTo: watchListViewCell.heightAnchor))
    }
    
    func adjustFontSizeToFitHeight () {
        watchListViewCell.adjustFontSizeToFitHeight()
        favouriteListViewCell.adjustFontSizeToFitHeight()
        seenListViewCell.adjustFontSizeToFitHeight()
        blackListViewCell.adjustFontSizeToFitHeight()
    }
}
