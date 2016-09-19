//
//  LoginViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 3/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var v = LoginView()
    var activeField:UITextField?
    var move = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.addSubview(v)
        v.loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        v.goCreateAccountFormButton.addTarget(self, action: #selector(self.createAccount), for: .touchUpInside)
        v.seTextFieldsDelegate(Delegate: self)
        setupConstraints()
        
    }
    
    //This method is called when the autolayout engine has finished to calculate your views' frames
    override func viewDidLayoutSubviews() {
        v.adjustFontSizeToFitHeight()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
    
    func login() {
        let user = v.userOrEmailTextFieldView.getText()
        let pass = v.passTextFieldView.getText()
        
        
        DataModel.sharedInstance.login(Username: user, Password: pass) {
            (data) in
            print("login")
            print(data)
        }
//        let tabBarController = UITabBarController()
//        let tab1 = SwipeTabViewController(nibName: nil, bundle: nil)
//        let tab2 = ViewController(nibName: nil, bundle: nil)
//        let tab3 = ViewController(nibName: nil, bundle: nil)
//        
//        let swipe = UIImage(named: "Swipe")
//        let thumbUp = UIImage(named: "thumb-up")
//        let account = UIImage(named: "account")
//        
//        tab1.tabBarItem = UITabBarItem(title: nil, image: swipe, tag: 1)
//        tab2.tabBarItem = UITabBarItem(title: nil, image: thumbUp, tag: 2)
//        tab3.tabBarItem = UITabBarItem(title: nil, image: account, tag: 3)
//        
//        let nVController1 = UINavigationController(rootViewController: tab1)
//        navigationController?.pushViewController(tabBarController, animated: true)
//        
//        //crear un protocolo que la vista tenga un nav controller con unos parametros por defectos que serán los siguientes
//        nVController1.navigationBar.topItem?.titleView = UIImageView(image: UIImage(named: "title")!.withRenderingMode(.alwaysOriginal))
//        nVController1.navigationBar.barTintColor = UIColor(netHex: mooviest_red)
//        nVController1.navigationItem.backBarButtonItem = nil
//        nVController1.navigationBar.barStyle = UIBarStyle.black
//        
//        
//        tabBarController.viewControllers = [nVController1, tab2, tab3]
//        
//        UITabBar.appearance().barTintColor = UIColor(netHex: mooviest_red)
//        UITabBar.appearance().tintColor = UIColor.white
//        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = tabBarController    
    }
    
    func createAccount(){
        let nextViewController = RegisterViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let origin = self.activeField!.convert((activeField?.frame.origin)!, from: self.view)
            
            print("textfield: \(origin.y)")
            let positionEnd = self.view.frame.size.height - keyboardSize.height - activeField!.frame.height
            print("positionEnd: \(positionEnd)")
            if origin.y + positionEnd < 0 {
                move = positionEnd + (origin.y)
                self.v.formView.frame.origin.y += self.move
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        print("exit keyboard")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return false to ignore.
        // textField.resignFirstResponder()
        let nextTag: NSInteger = textField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder? = self.view.viewWithTag(nextTag){
            nextResponder?.becomeFirstResponder()
        }
        else {
            if textField == v.passTextFieldView.textField {
                login()
            }
            
            // Not found, so remove keyboard.
            
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.3) {
            self.v.formView.frame.origin.y -= self.move
            self.move = 0
        }
        activeField = nil
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}
