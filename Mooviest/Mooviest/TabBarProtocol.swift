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
//        if let tbCtrl = vc.tabBarController as? AnimatedTabBarController,
//            let items = tbCtrl.tabBar.items as? [RAMAnimatedTabBarItem] {
//            for tbItmen in items {
//                tbItmen.iconColor = UIColor.white.withAlphaComponent(0.5)
//                tbItmen.textColor = tbItmen.iconColor
//                tbItmen.animation.iconSelectedColor = .white
//                tbItmen.animation.textSelectedColor = .white
//            }
//        }
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        vc.navigationController?.navigationBar.tintColor = .white
        vc.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
    }
    
    func setColors(viewController vc: UIViewController, backgroundColor: UIColor, tintColor:UIColor) {
//        vc.tabBarController?.tabBar.barTintColor = backgroundColor
//        if let tbCtrl = vc.tabBarController as? AnimatedTabBarController,
//            let items = tbCtrl.tabBar.items as? [RAMAnimatedTabBarItem] {
//            for tbItmen in items {
//                tbItmen.iconColor = tintColor.withAlphaComponent(0.5)
//                tbItmen.textColor = tbItmen.iconColor
//                tbItmen.animation.iconSelectedColor = tintColor
//                tbItmen.animation.textSelectedColor = tintColor
//            }
//        }
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: tintColor]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        vc.navigationController?.navigationBar.tintColor = tintColor
    }
}
