//
//  LoginView.swift
//  Mooviest
//
//  Created by Antonio RG on 3/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class LoginView: UIView {

    let height = UIApplication.sharedApplication().statusBarFrame.size.height
    var backgroundStatusView = UIView()
    var titleImageView = UIImageView()
    var userTextField = UITextField()
    var userLineImageView = UIImageView()
    var passTextField = UITextField()
    var passLineImageView = UIImageView()
    var loginButton = UIButton(type: UIButtonType.System) as UIButton
    var createAccountButton = UIButton(type: UIButtonType.System) as UIButton
    
    init() {
        super.init(frame: CGRect.zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = UIColor(netHex: mooviest_red)
        
        titleImageView.image = UIImage(named: "Mooviest")!.imageWithRenderingMode(.AlwaysOriginal)
        titleImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_red).colorWithAlphaComponent(0.5)
        
        userTextField.textColor = UIColor.whiteColor()
        userTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        
        passTextField.textColor = UIColor.whiteColor()
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        passTextField.secureTextEntry = true
        
        userLineImageView.backgroundColor = UIColor.whiteColor()
        passLineImageView.backgroundColor = UIColor.whiteColor()
        
        loginButton.backgroundColor = UIColor(netHex: dark_red).colorWithAlphaComponent(0.5)
        loginButton.setTitle("LOGIN", forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.layer.cornerRadius = 3
        
        createAccountButton.setTitle("No account yet? Create one", forState: .Normal)
        createAccountButton.setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.7), forState: .Normal)

        
        
        addSubview(backgroundStatusView)
        addSubview(titleImageView)
        addSubview(userTextField)
        addSubview(userLineImageView)
        addSubview(passTextField)
        addSubview(passLineImageView)
        addSubview(loginButton)
        addSubview(createAccountButton)
        
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userLineImageView.translatesAutoresizingMaskIntoConstraints = false
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        passLineImageView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraintEqualToConstant(height))
        
        addConstraint(titleImageView.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(titleImageView.topAnchor.constraintEqualToAnchor(backgroundStatusView.bottomAnchor, constant: 65))
        addConstraint(titleImageView.widthAnchor.constraintEqualToAnchor(widthAnchor,multiplier: 0.75))
        addConstraint(titleImageView.heightAnchor.constraintEqualToConstant(65))
        
        addConstraint(userTextField.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(userTextField.topAnchor.constraintEqualToAnchor(titleImageView.bottomAnchor, constant: 60))
        addConstraint(userTextField.widthAnchor.constraintEqualToAnchor(widthAnchor, multiplier: 0.8))
        addConstraint(userTextField.heightAnchor.constraintEqualToConstant(55))

        addConstraint(userLineImageView.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(userLineImageView.topAnchor.constraintEqualToAnchor(userTextField.bottomAnchor))
        addConstraint(userLineImageView.widthAnchor.constraintEqualToAnchor(userTextField.widthAnchor))
        addConstraint(userLineImageView.heightAnchor.constraintEqualToConstant(1))
        
        addConstraint(passTextField.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(passTextField.topAnchor.constraintEqualToAnchor(userLineImageView.bottomAnchor, constant: 30))
        addConstraint(passTextField.widthAnchor.constraintEqualToAnchor(widthAnchor, multiplier: 0.8))
        addConstraint(passTextField.heightAnchor.constraintEqualToConstant(50))
        
        addConstraint(passLineImageView.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(passLineImageView.topAnchor.constraintEqualToAnchor(passTextField.bottomAnchor))
        addConstraint(passLineImageView.widthAnchor.constraintEqualToAnchor(passTextField.widthAnchor))
        addConstraint(passLineImageView.heightAnchor.constraintEqualToConstant(1))

        addConstraint(loginButton.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(loginButton.topAnchor.constraintEqualToAnchor(passLineImageView.bottomAnchor,constant: 55))
        addConstraint(loginButton.widthAnchor.constraintEqualToAnchor(passLineImageView.widthAnchor))
        addConstraint(loginButton.heightAnchor.constraintEqualToConstant(40))

        addConstraint(createAccountButton.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(createAccountButton.topAnchor.constraintEqualToAnchor(loginButton.bottomAnchor,constant: 40))
        addConstraint(createAccountButton.widthAnchor.constraintEqualToAnchor(passLineImageView.widthAnchor))
        addConstraint(createAccountButton.heightAnchor.constraintEqualToConstant(20))
        
    }


}
