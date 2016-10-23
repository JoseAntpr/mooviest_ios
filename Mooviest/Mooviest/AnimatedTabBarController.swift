//
//  AnimatedTabBarController.swift
//  Mooviest
//
//  Created by Antonio RG on 7/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation
import AnimatedTabBar

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
        let nVController1 = UINavigationController(rootViewController: tab1)
        nVController1.navigationBar.topItem?.title = tbItem1.title!
        nVController1.navigationBar.barStyle = UIBarStyle.black
        nVController1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nVController1.navigationBar.shadowImage = UIImage()
        nVController1.navigationBar.isTranslucent = true
        nVController1.navigationBar.clipsToBounds = true
        nVController1.navigationBar.tintColor = UIColor.white
        nVController1.tabBarItem = tbItem1
        
        //tab2 Advice
        let tbItem2 = createAnimatedTabBarItem(title: "Advice", animation: RAMBounceAnimation(),
                                               namedIcon: "thumb-up", color: UIColor.white.withAlphaComponent(0.5),
                                               colorSelected: .white)
        let tab2 = ViewController(nibName: nil, bundle: nil)
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
        let nVController4 = UINavigationController(rootViewController: tab4)
        nVController4.navigationBar.topItem?.title = tbItem4.title!
        nVController4.navigationBar.barStyle = UIBarStyle.black
        nVController4.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nVController4.navigationBar.shadowImage = UIImage()
        nVController4.navigationBar.isTranslucent = true
        nVController4.navigationBar.clipsToBounds = true
        nVController4.navigationBar.tintColor = UIColor.white
        nVController4.tabBarItem = tbItem4
        
        self.viewControllers = [nVController1, nVController2, nVController3, nVController4]
        self.tabBar.barTintColor = UIColor(netHex: mooviest_red)
        self.tabBar.isTranslucent = false 
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }   
}

