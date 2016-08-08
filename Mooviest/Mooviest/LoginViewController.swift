//
//  LoginViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 3/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var v = LoginView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(v)
        v.loginButton.addTarget(self, action: #selector(self.login), forControlEvents: .TouchUpInside)
        setupConstraints()
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
    
    func login() {
        let tabBarController = UITabBarController()
        let tab1 = SwipeTabViewController(nibName: nil, bundle: nil)
        let tab2 = ViewController(nibName: nil, bundle: nil)
        let tab3 = ViewController(nibName: nil, bundle: nil)
        
        let swipe = UIImage(named: "Swipe")
        let thumbUp = UIImage(named: "thumb-up")
        let account = UIImage(named: "account")
        
        tab1.tabBarItem = UITabBarItem(title: nil, image: swipe, tag: 1)
        tab2.tabBarItem = UITabBarItem(title: nil, image: thumbUp, tag: 2)
        tab3.tabBarItem = UITabBarItem(title: nil, image: account, tag: 3)
        
        let nVController1 = UINavigationController(rootViewController: tab1)
        navigationController?.pushViewController(tabBarController, animated: true)
        
        //crear un protocolo que la vista tenga un nav controller con unos parametros por defectos que serán los siguientes
        nVController1.navigationBar.topItem?.titleView = UIImageView(image: UIImage(named: "title")!.imageWithRenderingMode(.AlwaysOriginal))
        nVController1.navigationBar.barTintColor = UIColor(netHex: mooviest_red)
        nVController1.navigationItem.backBarButtonItem = nil
        nVController1.navigationBar.barStyle = UIBarStyle.Black
        
        
        tabBarController.viewControllers = [nVController1, tab2, tab3]
        
        UITabBar.appearance().barTintColor = UIColor(netHex: 0x940224)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
       
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
