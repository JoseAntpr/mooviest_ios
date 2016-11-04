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
//        vc.tabBarController?.tabBar.barTintColor = mooviest_red
//        vc.tabBarController?.tabBar.tintColor = .white
//        if #available(iOS 10.0, *) {
//            vc.tabBarController?.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.5)
//        } else {
//            // Fallback on earlier versions
//        }
//        vc.tabBarController?.tabBar.isTranslucent = false
//        vc.tabBarController?.tabBar.isHidden = false
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: mooviest_red]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        vc.navigationController?.navigationBar.tintColor = mooviest_red
        vc.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
    }
    
    func setColors(viewController vc: UIViewController, backgroundColor: UIColor, tintColor:UIColor) {
//        vc.tabBarController?.tabBar.barTintColor = backgroundColor
//        vc.tabBarController?.tabBar.tintColor = tintColor
//        if #available(iOS 10.0, *) {
//            vc.tabBarController?.tabBar.unselectedItemTintColor = tintColor.withAlphaComponent(0.5)
//        } else {
//            // Fallback on earlier versions
//        }
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: tintColor]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        vc.navigationController?.navigationBar.tintColor = tintColor
    }
}
