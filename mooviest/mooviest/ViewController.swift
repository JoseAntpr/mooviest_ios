//
//  ViewController.swift
//  mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var v = FilmTabView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(v)
        v.label.textColor = UIColor.blackColor()
        setupConstraints()
         
        UITabBar.appearance().barTintColor = UIColor(netHex: 0x940224)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraintEqualToAnchor(view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraintEqualToAnchor(view.rightAnchor))
        view.addConstraint(v.topAnchor.constraintEqualToAnchor(view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor))
    }

}

