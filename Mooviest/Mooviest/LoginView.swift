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
    
    var formView = UIView()
    var padingformView = UIView()
    
    var userOrEmailTextFieldView = TextFieldView()
    var passTextFieldView = TextFieldView()
    
    var centralView = UIView()
    var loginButton = UIButton(type: UIButtonType.system) as UIButton
    var goCreateAccountFormButton = UIButton(type: UIButtonType.system) as UIButton
    
    
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
        
        formView.backgroundColor = UIColor.white
        //        formView.layer.shadowColor = UIColor.orange.cgColor
        //        formView.layer.shadowOpacity = 1
        //        formView.layer.shadowOffset = CGSize(width: 3, height: 3)
        //        formView.layer.shadowRadius = 10
        
        formView.layer.cornerRadius = 3
        formView.layer.masksToBounds = true
        
        padingformView.backgroundColor = UIColor.white.withAlphaComponent(0)
        centralView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        userOrEmailTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        userOrEmailTextFieldView.setPlaceholder(Placeholder: "Username or email", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        userOrEmailTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        userOrEmailTextFieldView.setReturnKeyType(returnKeyType: .next)
        userOrEmailTextFieldView.textField.tag = 0
        
        passTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        passTextFieldView.setPlaceholder(Placeholder: "Password", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        passTextFieldView.setSecureText(isSecureTextEntry: true)
        passTextFieldView.setReturnKeyType(returnKeyType: .default)
        passTextFieldView.textField.tag = 1
        
        loginButton.backgroundColor = UIColor(netHex: mooviest_red)
        loginButton.setTitle("LOGIN", for: UIControlState())
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.layer.cornerRadius = 3
        
        goCreateAccountFormButton.setTitle(NSLocalizedString("titleCreateAccountButton", comment: "Title of goCreateAccountFormButton"), for: UIControlState())
        goCreateAccountFormButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: UIControlState())
        
        formView.addSubview(padingformView)
        padingformView.addSubview(userOrEmailTextFieldView)
        padingformView.addSubview(passTextFieldView)
        padingformView.addSubview(loginButton)
        centralView.addSubview(formView)
        
        addSubview(backgroundStatusView)
        addSubview(titleImageView)
        addSubview(goCreateAccountFormButton)
        addSubview(centralView)
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        formView.translatesAutoresizingMaskIntoConstraints = false
        padingformView.translatesAutoresizingMaskIntoConstraints = false
        userOrEmailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        passTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        centralView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        goCreateAccountFormButton.translatesAutoresizingMaskIntoConstraints = false
       
        
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(titleImageView.topAnchor.constraint(equalTo: backgroundStatusView.bottomAnchor))
        addConstraint(titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(titleImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.75))
        addConstraint(titleImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2))
        
        addConstraint(goCreateAccountFormButton.bottomAnchor.constraint(equalTo: bottomAnchor))
        addConstraint(goCreateAccountFormButton.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(goCreateAccountFormButton.widthAnchor.constraint(equalTo: formView.widthAnchor))
        addConstraint(goCreateAccountFormButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15))
        
        addConstraint(centralView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor))
        addConstraint(centralView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(centralView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(centralView.bottomAnchor.constraint(equalTo: goCreateAccountFormButton.topAnchor))
        
        centralView.addConstraint(formView.centerYAnchor.constraint(equalTo: centralView.centerYAnchor))
        centralView.addConstraint(formView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        centralView.addConstraint(formView.widthAnchor.constraint(equalTo: centralView.widthAnchor,multiplier: 0.8))
        centralView.addConstraint(formView.heightAnchor.constraint(equalTo: centralView.heightAnchor, multiplier: 0.75))
        
        formView.addConstraint(padingformView.centerYAnchor.constraint(equalTo: formView.centerYAnchor))
        formView.addConstraint(padingformView.centerXAnchor.constraint(equalTo: formView.centerXAnchor))
        formView.addConstraint(padingformView.widthAnchor.constraint(equalTo: formView.widthAnchor, multiplier: 0.9))
        formView.addConstraint(padingformView.heightAnchor.constraint(equalTo: formView.heightAnchor, multiplier: 0.8))
        
        padingformView.addConstraint(userOrEmailTextFieldView.topAnchor.constraint(equalTo: padingformView.topAnchor))
        padingformView.addConstraint(userOrEmailTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(userOrEmailTextFieldView.widthAnchor.constraint(equalTo: padingformView.widthAnchor))
        padingformView.addConstraint(userOrEmailTextFieldView.heightAnchor.constraint(equalTo: padingformView.heightAnchor, multiplier: 0.4))
        
        padingformView.addConstraint(passTextFieldView.topAnchor.constraint(equalTo: userOrEmailTextFieldView.bottomAnchor))
        padingformView.addConstraint(passTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(passTextFieldView.widthAnchor.constraint(equalTo: userOrEmailTextFieldView.widthAnchor))
        padingformView.addConstraint(passTextFieldView.heightAnchor.constraint(equalTo: userOrEmailTextFieldView.heightAnchor))
        
        padingformView.addConstraint(loginButton.bottomAnchor.constraint(equalTo: padingformView.bottomAnchor))
        padingformView.addConstraint(loginButton.leftAnchor.constraint(equalTo: padingformView.leftAnchor))
        padingformView.addConstraint(loginButton.widthAnchor.constraint(equalTo: padingformView.widthAnchor))
        padingformView.addConstraint(loginButton.heightAnchor.constraint(equalTo: userOrEmailTextFieldView.heightAnchor,multiplier: 0.5))
    }
    
    func seTextFieldsDelegate(Delegate d: UITextFieldDelegate){
        userOrEmailTextFieldView.setDelegate(Delegate: d)
        passTextFieldView.setDelegate(Delegate: d)
    }
    
    func adjustFontSizeToFitHeight () {
        userOrEmailTextFieldView.adjustFontSizeToFitHeight()
        passTextFieldView.adjustFontSizeToFitHeight()
    }    
}
