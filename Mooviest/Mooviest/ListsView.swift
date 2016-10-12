//
//  ListsView.swift
//  Mooviest
//
//  Created by Antonio RG on 11/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class ListsView: UIView {
    let listView = UIView()
    let watchListViewCell = ItemListView()
    let favouriteListViewCell = ItemListView()
    let seenListViewCell = ItemListView()
    
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
        
        watchListViewCell.titleLabel.text = "Watch"
        favouriteListViewCell.titleLabel.text = "Favourite"
        seenListViewCell.titleLabel.text = "Seen"
        
        listView.addSubview(watchListViewCell)
        listView.addSubview(favouriteListViewCell)
        listView.addSubview(seenListViewCell)
        addSubview(listView)
    }
    
    func setupConstraints() {
        listView.translatesAutoresizingMaskIntoConstraints = false
        watchListViewCell.translatesAutoresizingMaskIntoConstraints = false
        favouriteListViewCell.translatesAutoresizingMaskIntoConstraints = false
        seenListViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(listView.centerYAnchor.constraint(equalTo: centerYAnchor))
        addConstraint(listView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(listView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.90))
        addConstraint(listView.heightAnchor.constraint(equalTo: heightAnchor,multiplier: 0.98))
        
        listView.addConstraint(watchListViewCell.centerXAnchor.constraint(equalTo: listView.centerXAnchor))
        listView.addConstraint(watchListViewCell.topAnchor.constraint(equalTo: listView.topAnchor))
        listView.addConstraint(watchListViewCell.widthAnchor.constraint(equalTo: listView.widthAnchor))
        listView.addConstraint(watchListViewCell.heightAnchor.constraint(equalTo: listView.heightAnchor, multiplier:0.33))
        
        listView.addConstraint(favouriteListViewCell.centerXAnchor.constraint(equalTo: listView.centerXAnchor))
        listView.addConstraint(favouriteListViewCell.centerYAnchor.constraint(equalTo: listView.centerYAnchor))
        listView.addConstraint(favouriteListViewCell.widthAnchor.constraint(equalTo: listView.widthAnchor))
        listView.addConstraint(favouriteListViewCell.heightAnchor.constraint(equalTo: listView.heightAnchor, multiplier:0.33))
        
        listView.addConstraint(seenListViewCell.centerXAnchor.constraint(equalTo: listView.centerXAnchor))
        listView.addConstraint(seenListViewCell.bottomAnchor.constraint(equalTo: listView.bottomAnchor))
        listView.addConstraint(seenListViewCell.widthAnchor.constraint(equalTo: listView.widthAnchor))
        listView.addConstraint(seenListViewCell.heightAnchor.constraint(equalTo: listView.heightAnchor, multiplier:0.33))
    }
}
