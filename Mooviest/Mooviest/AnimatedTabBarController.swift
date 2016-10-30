//
//  AnimatedTabBarController.swift
//  Mooviest
//
//  Created by Antonio RG on 7/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class AnimatedTabBarController: RAMAnimatedTabBarController {
    
    override func viewDidLoad() {
        makeTabBar()
        super.viewDidLoad()
    }
    
    func createNavigationController(rootViewController vc: UIViewController,
                                    title t: String)-> UINavigationController {
        let nVController = UINavigationController(rootViewController: vc)
        
        nVController.navigationBar.topItem?.title = t
        nVController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nVController.navigationBar.shadowImage = UIImage()
        nVController.navigationBar.barStyle = UIBarStyle.black
        nVController.navigationBar.isTranslucent = true
        nVController.navigationBar.clipsToBounds = true
        nVController.navigationBar.tintColor = UIColor.white
        
        return nVController
    }
    
    func createAnimatedTabBarItem(title t: String, animation a: RAMItemAnimation,
                                  namedIcon ni: String, color c: UIColor,
                                  colorSelected cs: UIColor)-> RAMAnimatedTabBarItem {
        let icon =  UIImage(named:ni)
        let tbItem = RAMAnimatedTabBarItem(
            title: t,
            image: icon,
            selectedImage: icon
        )
        tbItem.iconColor = c
        tbItem.textColor = c
        tbItem.animation = a
        tbItem.animation.iconSelectedColor = cs
        tbItem.animation.textSelectedColor = cs
        
        return tbItem
    }
    
    func makeTabBar() {
        //tab1 Swipe
        let tbItem1 = createAnimatedTabBarItem(title: "Swipe", animation: RAMBounceAnimation(),
                                               namedIcon: "swipe", color: UIColor.white.withAlphaComponent(0.5),
                                               colorSelected: .white)
        let tab1 = SwipeTabViewController(nibName: nil, bundle: nil)
        let nVController1 = createNavigationController(rootViewController: tab1, title: tbItem1.title!)
        nVController1.tabBarItem = tbItem1
        
        //tab2 Advice
        let tbItem2 = createAnimatedTabBarItem(title: "Advice", animation: RAMBounceAnimation(),
                                               namedIcon: "thumb-up", color: UIColor.white.withAlphaComponent(0.5),
                                               colorSelected: .white)
        let tab2 = AdviceViewController(nibName: nil, bundle: nil)
        let nVController2 = createNavigationController(rootViewController: tab2, title: tbItem2.title!)
        nVController2.tabBarItem = tbItem2
        
        //tab3 Lists
        let tbItem3 = createAnimatedTabBarItem(title: "Lists", animation: RAMBounceAnimation(),
                                               namedIcon: "list", color: UIColor.white.withAlphaComponent(0.5),
                                               colorSelected: .white)
        let tab3 = ListsViewController(nibName: nil, bundle: nil)
        let nVController3 = createNavigationController(rootViewController: tab3, title: tbItem3.title!)
        nVController3.tabBarItem = tbItem3
        
        //tab4 Profile
        let tbItem4 = createAnimatedTabBarItem(title: "Profile", animation: RAMBounceAnimation(),
                                               namedIcon: "profile", color: UIColor.white.withAlphaComponent(0.5),
                                               colorSelected: .white)
        let tab4 = ProfileViewController(nibName: nil, bundle: nil)
        let nVController4 = createNavigationController(rootViewController: tab4, title: tbItem4.title!)
        nVController4.tabBarItem = tbItem4
        
        self.viewControllers = [nVController1, nVController2, nVController3, nVController4]
        self.tabBar.barTintColor =   mooviest_red
        self.tabBar.isTranslucent = false 
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }   
}

