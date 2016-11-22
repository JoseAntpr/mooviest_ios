//
//  TabBarProtocol.swift
//  Mooviest
//
//  Created by Antonio RG on 30/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

protocol TabBarProtocol {
}

extension TabBarProtocol {
    
    func resetTabBarAndNavigationController(viewController vc: UIViewController) {
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.black]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        vc.navigationController?.navigationBar.tintColor = mooviest_red
        vc.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
    }
    
    func setColors(viewController vc: UIViewController, backgroundColor: UIColor, tintColor:UIColor) {
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: tintColor]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        vc.navigationController?.navigationBar.tintColor = tintColor
    }
}
