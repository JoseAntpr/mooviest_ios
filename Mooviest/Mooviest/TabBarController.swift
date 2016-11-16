//
//  AnimatedTabBarController.swift
//  Mooviest
//
//  Created by Antonio RG on 7/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        makeTabBar()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

        return nVController
    }
    
    func makeTabBar() {
        //tab1 Swipe
        let tbItem1 = UITabBarItem(title: "Swipe",
            image: UIImage(named: "swipe")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(named: "swipe")?.withRenderingMode(.alwaysTemplate))
        
        let tab1 = SwipeTabViewController(nibName: nil, bundle: nil)
        let nVController1 = createNavigationController(rootViewController: tab1, title: "")
        let titleView =  UIImageView(image: UIImage(named: "m")?.withRenderingMode(.alwaysTemplate))
        titleView.tintColor = mooviest_red
        nVController1.navigationBar.topItem?.titleView = titleView
        nVController1.tabBarItem = tbItem1

        //tab2 Lists
        let tbItem2 = UITabBarItem(title: "Listas",
                                   image: UIImage(named: "list")?.withRenderingMode(.alwaysTemplate),
                                   selectedImage: UIImage(named: "list")?.withRenderingMode(.alwaysTemplate))
        
        let tab2 = ListsViewController(nibName: nil, bundle: nil)

        let nVController2 = createNavigationController(rootViewController: tab2, title: tbItem2.title!)
        nVController2.tabBarItem = tbItem2
        
        //tab3 Profile
        let tbItem3 = UITabBarItem(title: "Perfil",
                                   image: UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate),
                                   selectedImage: UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate))

        let tab3 = ProfileViewController(nibName: nil, bundle: nil)
        let nVController3 = createNavigationController(rootViewController: tab3, title: tbItem3.title!)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        nVController3.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        nVController3.tabBarItem = tbItem3
        
        self.viewControllers = [nVController1, nVController2, nVController3]
        self.tabBar.barTintColor = barTintColor
        self.tabBar.tintColor = mooviest_red
        self.tabBar.isTranslucent = false
    }
}

