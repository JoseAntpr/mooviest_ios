//
//  RegisterView.swift
//  Mooviest
//
//  Created by Antonio RG on 16/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//


import UIKit

class RegisterView: UIView {
    
    let height = UIApplication.shared.statusBarFrame.size.height
    var backgroundStatusView = UIView()
    var titleImageView = UIImageView()
    
    
    
    
    var formView = UIView()
    var padingformView = UIView()
    var centralView = UIView()
    var userTextFieldView = TextFieldView()
    var emailTextFieldView = TextFieldView()
    var passTextFieldView = TextFieldView()
    var confirmPassTextFieldView = TextFieldView()
    var createAccountButton = UIButton(type: UIButtonType.system) as UIButton
    
    var backLoginButton = UIButton(type: UIButtonType.system) as UIButton
    
    
    init() {
        super.init(frame: CGRect.zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor =   mooviest_red
        
        titleImageView.image = UIImage(named: "Mooviest")!.withRenderingMode(.alwaysOriginal)
        titleImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        backgroundStatusView.backgroundColor =   dark_red.withAlphaComponent(0.5)
        
        formView.backgroundColor = UIColor.white
        formView.layer.cornerRadius = 3
        formView.layer.masksToBounds = true
        
        padingformView.backgroundColor = UIColor.white.withAlphaComponent(0)
        centralView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        userTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        userTextFieldView.setPlaceholder(Placeholder: "Username", PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        userTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        userTextFieldView.setReturnKeyType(returnKeyType: .next)
        userTextFieldView.textField.tag = 0
       
        
        emailTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        emailTextFieldView.setPlaceholder(Placeholder: "Email", PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        emailTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.emailAddress)
        emailTextFieldView.setReturnKeyType(returnKeyType: .next)
        emailTextFieldView.textField.tag = 1
        
        passTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        passTextFieldView.setPlaceholder(Placeholder: "Password", PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        passTextFieldView.setSecureText(isSecureTextEntry: true)
        passTextFieldView.setReturnKeyType(returnKeyType: .next)
        passTextFieldView.textField.tag = 2
        
        confirmPassTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        confirmPassTextFieldView.setPlaceholder(Placeholder: "Confirm password", PlaceholderColor: placeholder_gray.withAlphaComponent(0.7))
        confirmPassTextFieldView.setSecureText(isSecureTextEntry: true)
        confirmPassTextFieldView.setReturnKeyType(returnKeyType: .default)
        confirmPassTextFieldView.textField.tag = 3
        
        createAccountButton.backgroundColor = mooviest_red
        createAccountButton.setTitle(NSLocalizedString("createAccountButton", comment: "Title of createAccountButton"), for: UIControlState())
        createAccountButton.setTitleColor(UIColor.white, for: UIControlState())
        createAccountButton.layer.cornerRadius = 3
        
        backLoginButton.setTitle(NSLocalizedString("backloginButton", comment: "Title of backLoginButton"), for: UIControlState())
        backLoginButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: UIControlState())
       
        formView.addSubview(padingformView)
        padingformView.addSubview(userTextFieldView)
        padingformView.addSubview(emailTextFieldView)
        padingformView.addSubview(passTextFieldView)
        padingformView.addSubview(confirmPassTextFieldView)
        padingformView.addSubview(createAccountButton)
        centralView.addSubview(formView)
        
        addSubview(backLoginButton)
        addSubview(backgroundStatusView)
        addSubview(titleImageView)
        addSubview(centralView)
        
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        formView.translatesAutoresizingMaskIntoConstraints = false
        padingformView.translatesAutoresizingMaskIntoConstraints = false
        userTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        passTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        confirmPassTextFieldView.translatesAutoresizingMaskIntoConstraints = false
       
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        backLoginButton.translatesAutoresizingMaskIntoConstraints = false
        centralView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(titleImageView.topAnchor.constraint(equalTo: backgroundStatusView.bottomAnchor))
        addConstraint(titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(titleImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.75))
        addConstraint(titleImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2))
        
        addConstraint(backLoginButton.bottomAnchor.constraint(equalTo: bottomAnchor))
        addConstraint(backLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(backLoginButton.widthAnchor.constraint(equalTo: formView.widthAnchor))
        addConstraint(backLoginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15))
        
        addConstraint(centralView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor))
        addConstraint(centralView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(centralView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(centralView.bottomAnchor.constraint(equalTo: backLoginButton.topAnchor))
       
        centralView.addConstraint(formView.centerYAnchor.constraint(equalTo: centralView.centerYAnchor))
        centralView.addConstraint(formView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        centralView.addConstraint(formView.widthAnchor.constraint(equalTo: centralView.widthAnchor,multiplier: 0.8))
        centralView.addConstraint(formView.heightAnchor.constraint(equalTo: centralView.heightAnchor, multiplier: 0.9))
    
        formView.addConstraint(padingformView.centerYAnchor.constraint(equalTo: formView.centerYAnchor))
        formView.addConstraint(padingformView.centerXAnchor.constraint(equalTo: formView.centerXAnchor))
        formView.addConstraint(padingformView.widthAnchor.constraint(equalTo: formView.widthAnchor, multiplier: 0.9))
        formView.addConstraint(padingformView.heightAnchor.constraint(equalTo: formView.heightAnchor, multiplier: 0.85))
        
        padingformView.addConstraint(userTextFieldView.topAnchor.constraint(equalTo: padingformView.topAnchor))
        padingformView.addConstraint(userTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(userTextFieldView.widthAnchor.constraint(equalTo: padingformView.widthAnchor))
        padingformView.addConstraint(userTextFieldView.heightAnchor.constraint(equalTo: padingformView.heightAnchor, multiplier: 0.22))
        
        padingformView.addConstraint(emailTextFieldView.topAnchor.constraint(equalTo: userTextFieldView.bottomAnchor))
        padingformView.addConstraint(emailTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(emailTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingformView.addConstraint(emailTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        padingformView.addConstraint(passTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor))
        padingformView.addConstraint(passTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(passTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingformView.addConstraint(passTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
  
        padingformView.addConstraint(confirmPassTextFieldView.topAnchor.constraint(equalTo: passTextFieldView.bottomAnchor))
        padingformView.addConstraint(confirmPassTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(confirmPassTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingformView.addConstraint(confirmPassTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        padingformView.addConstraint(createAccountButton.bottomAnchor.constraint(equalTo: padingformView.bottomAnchor))
        padingformView.addConstraint(createAccountButton.leftAnchor.constraint(equalTo: padingformView.leftAnchor))
        padingformView.addConstraint(createAccountButton.widthAnchor.constraint(equalTo: padingformView.widthAnchor))
        padingformView.addConstraint(createAccountButton.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor,multiplier: 0.6))

    }
    
    func seTextFieldsDelegate(Delegate d: UITextFieldDelegate){
        userTextFieldView.setDelegate(Delegate: d)
        emailTextFieldView.setDelegate(Delegate: d)
        passTextFieldView.setDelegate(Delegate: d)
        confirmPassTextFieldView.setDelegate(Delegate: d)
    }
    
    func adjustFontSizeToFitHeight () {
        userTextFieldView.adjustFontSizeToFitHeight()
        emailTextFieldView.adjustFontSizeToFitHeight()
        passTextFieldView.adjustFontSizeToFitHeight()
        confirmPassTextFieldView.adjustFontSizeToFitHeight()
    }
}
