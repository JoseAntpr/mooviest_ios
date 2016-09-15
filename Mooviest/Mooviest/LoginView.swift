//
//  LoginView.swift
//  Mooviest
//
//  Created by Antonio RG on 3/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    let height = UIApplication.shared.statusBarFrame.size.height
    var backgroundStatusView = UIView()
    var titleImageView = UIImageView()
    var userTextField = UITextField()
    var userLineImageView = UIImageView()
    var passTextField = UITextField()
    var passLineImageView = UIImageView()
    var loginButton = UIButton(type: UIButtonType.system) as UIButton
    var createAccountButton = UIButton(type: UIButtonType.system) as UIButton
    
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
        
        titleImageView.image = UIImage(named: "Mooviest")!.withRenderingMode(.alwaysOriginal)
        titleImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_red).withAlphaComponent(0.5)
        
        userTextField.textColor = UIColor.white
        userTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName : UIColor.white])
        
        passTextField.textColor = UIColor.white
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.white])
        passTextField.isSecureTextEntry = true
        
        userLineImageView.backgroundColor = UIColor.white
        passLineImageView.backgroundColor = UIColor.white
        
        loginButton.backgroundColor = UIColor(netHex: dark_red).withAlphaComponent(0.5)
        loginButton.setTitle("LOGIN", for: UIControlState())
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.layer.cornerRadius = 3
        
        createAccountButton.setTitle(NSLocalizedString("titleCreateAccountButton", comment: "Title of createAccountButton"), for: UIControlState())
        createAccountButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: UIControlState())
        
        
        
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
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(titleImageView.topAnchor.constraint(equalTo: backgroundStatusView.bottomAnchor, constant: 65))
        addConstraint(titleImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.75))
        addConstraint(titleImageView.heightAnchor.constraint(equalToConstant: 65))
        
        addConstraint(userTextField.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(userTextField.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 60))
        addConstraint(userTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8))
        addConstraint(userTextField.heightAnchor.constraint(equalToConstant: 55))
        
        addConstraint(userLineImageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(userLineImageView.topAnchor.constraint(equalTo: userTextField.bottomAnchor))
        addConstraint(userLineImageView.widthAnchor.constraint(equalTo: userTextField.widthAnchor))
        addConstraint(userLineImageView.heightAnchor.constraint(equalToConstant: 1))
        
        addConstraint(passTextField.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(passTextField.topAnchor.constraint(equalTo: userLineImageView.bottomAnchor, constant: 30))
        addConstraint(passTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8))
        addConstraint(passTextField.heightAnchor.constraint(equalToConstant: 50))
        
        addConstraint(passLineImageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(passLineImageView.topAnchor.constraint(equalTo: passTextField.bottomAnchor))
        addConstraint(passLineImageView.widthAnchor.constraint(equalTo: passTextField.widthAnchor))
        addConstraint(passLineImageView.heightAnchor.constraint(equalToConstant: 1))
        
        addConstraint(loginButton.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(loginButton.topAnchor.constraint(equalTo: passLineImageView.bottomAnchor,constant: 55))
        addConstraint(loginButton.widthAnchor.constraint(equalTo: passLineImageView.widthAnchor))
        addConstraint(loginButton.heightAnchor.constraint(equalToConstant: 40))
        
        addConstraint(createAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 40))
        addConstraint(createAccountButton.widthAnchor.constraint(equalTo: passLineImageView.widthAnchor))
        addConstraint(createAccountButton.heightAnchor.constraint(equalToConstant: 20))
        
    }
    
    
}
