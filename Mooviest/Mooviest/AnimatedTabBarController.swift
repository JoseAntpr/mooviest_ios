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
    
    func createNavigationController(rootViewController vc: UIViewController)-> UINavigationController {
        let nVController = UINavigationController(rootViewController: vc)
        
        nVController.navigationBar.topItem?.titleView = UIImageView(image: UIImage(named: "title")!.withRenderingMode(.alwaysOriginal))
        nVController.navigationBar.barTintColor = UIColor(netHex: mooviest_red)
        nVController.navigationItem.backBarButtonItem = nil
        nVController.navigationBar.barStyle = UIBarStyle.black
        nVController.navigationBar.isTranslucent = false
        
        return nVController
    }
    
    func makeTabBar() {
        //tab1 Swipe
        let tab1 = SwipeTabViewController(nibName: nil, bundle: nil)
        let nVController1 = createNavigationController(rootViewController: tab1)
        let icon1 =  UIImage(named: "swipe")
        let tbItem1 = RAMAnimatedTabBarItem(
            title: "Swipe",
            image: icon1,
            selectedImage: icon1
        )
        
        tbItem1.animation = RAMBounceAnimation()
        tbItem1.animation.iconSelectedColor = UIColor.white
        tbItem1.animation.textSelectedColor = UIColor.white
        
        tbItem1.iconColor = UIColor.white.withAlphaComponent(0.5)
        tbItem1.textColor = UIColor.white.withAlphaComponent(0.5)
        nVController1.tabBarItem = tbItem1
        
        //tab2 Advice
        
        let tab2 = ViewController(nibName: nil, bundle: nil)
        let nVController2 = createNavigationController(rootViewController: tab2)
        let icon2 =  UIImage(named: "thumb-up")
        let tbItem2 = RAMAnimatedTabBarItem(
            title: "Advice",
            image: icon2,
            selectedImage: icon2
        )
        
        tbItem2.animation = RAMBounceAnimation()
        tbItem2.animation.iconSelectedColor = UIColor.white
        tbItem2.animation.textSelectedColor = UIColor.white
        
        tbItem2.iconColor = UIColor.white.withAlphaComponent(0.5)
        tbItem2.textColor = UIColor.white.withAlphaComponent(0.5)
        nVController2.tabBarItem = tbItem2
        
        //tab3 Lists
        let tab3 = ViewController(nibName: nil, bundle: nil)
        let nVController3 = createNavigationController(rootViewController: tab3)
        let icon3 =  UIImage(named: "list")
        let tbItem3 = RAMAnimatedTabBarItem(
            title: "Lists",
            image: icon3,
            selectedImage: icon3
        )
        
        tbItem3.animation = RAMBounceAnimation()
        tbItem3.animation.iconSelectedColor = UIColor.white
        tbItem3.animation.textSelectedColor = UIColor.white
        
        tbItem3.iconColor = UIColor.white.withAlphaComponent(0.5)
        tbItem3.textColor = UIColor.white.withAlphaComponent(0.5)
        nVController3.tabBarItem = tbItem3
        
        //tab4 Profile
        let tab4 = ProfileViewController(nibName: nil, bundle: nil)
        let nVController4 = createNavigationController(rootViewController: tab4)
        nVController4.isNavigationBarHidden = true
        let icon4 =  UIImage(named: "profile")
        let tbItem4 = RAMAnimatedTabBarItem(
            title: "Profile",
            image: icon4,
            selectedImage: icon4
        )
        
        tbItem4.animation = RAMBounceAnimation()
        tbItem4.animation.iconSelectedColor = UIColor.white
        tbItem4.animation.textSelectedColor = UIColor.white
        
        tbItem4.iconColor = UIColor.white.withAlphaComponent(0.5)
        tbItem4.textColor = UIColor.white.withAlphaComponent(0.5)
        nVController4.tabBarItem = tbItem4
        
        self.viewControllers = [nVController1, nVController2, nVController3, nVController4]
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor(netHex: mooviest_red)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }   
}

