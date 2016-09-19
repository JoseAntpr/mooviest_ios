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
    var passLoginTextFieldView = TextFieldView()
    
    var centralView = UIView()
    var loginButton = UIButton(type: UIButtonType.system) as UIButton
    var goCreateAccountFormButton = UIButton() 
    
    var formRegisterView = UIView()
    var padingRegisterformView = UIView()
    var userTextFieldView = TextFieldView()
    var emailTextFieldView = TextFieldView()
    var passTextFieldView = TextFieldView()
    var confirmPassTextFieldView = TextFieldView()
    var createAccountButton = UIButton(type: UIButtonType.system) as UIButton
    var backLoginButton = UIButton()
    var formRegisterViewCenterXAnchor:NSLayoutConstraint!
    var formRegisterViewCenterYAnchor:NSLayoutConstraint!
    
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
        //Form Login
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
        userOrEmailTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.emailAddress)
        userOrEmailTextFieldView.setReturnKeyType(returnKeyType: .next)
        userOrEmailTextFieldView.textField.tag = 0
        userOrEmailTextFieldView.editTextButton.setImage(UIImage(named: "replay"), for: UIControlState())
        userOrEmailTextFieldView.editTextButton.tintColor = UIColor(netHex: placeholder_gray).withAlphaComponent(0.4)
        
        passLoginTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        passLoginTextFieldView.setPlaceholder(Placeholder: "Password", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        passLoginTextFieldView.setSecureText(isSecureTextEntry: true)
        passLoginTextFieldView.setReturnKeyType(returnKeyType: .join)
        passLoginTextFieldView.textField.tag = 1
        passLoginTextFieldView.editTextButton.setImage(UIImage(named: "eye"), for: UIControlState())
        passLoginTextFieldView.editTextButton.tintColor = UIColor(netHex: placeholder_gray).withAlphaComponent(0.4)
        
        loginButton.backgroundColor = UIColor(netHex: mooviest_red)
        loginButton.setTitle("LOGIN", for: UIControlState())
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.layer.cornerRadius = 3
        
        goCreateAccountFormButton.setTitle(NSLocalizedString("titleCreateAccountButton", comment: "Title of goCreateAccountFormButton"), for: UIControlState())
        goCreateAccountFormButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: UIControlState())
        
        //Form Register
        formRegisterView.backgroundColor = UIColor.white
        formRegisterView.layer.cornerRadius = 3
        formRegisterView.layer.masksToBounds = true
        
        padingRegisterformView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        userTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        userTextFieldView.setPlaceholder(Placeholder: "Username", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        userTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        userTextFieldView.setReturnKeyType(returnKeyType: .next)
        userTextFieldView.textField.tag = 2
        userTextFieldView.editTextButton.setImage(UIImage(named: "replay"), for: UIControlState())
        userTextFieldView.editTextButton.tintColor = UIColor(netHex: placeholder_gray).withAlphaComponent(0.4)
        
        emailTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        emailTextFieldView.setPlaceholder(Placeholder: "Email", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        emailTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.emailAddress)
        emailTextFieldView.setReturnKeyType(returnKeyType: .next)
        emailTextFieldView.textField.tag = 3
        emailTextFieldView.editTextButton.setImage(UIImage(named: "replay"), for: UIControlState())
        emailTextFieldView.editTextButton.tintColor = UIColor(netHex: placeholder_gray).withAlphaComponent(0.4)
        
        passTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        passTextFieldView.setPlaceholder(Placeholder: "Password", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        passTextFieldView.setSecureText(isSecureTextEntry: true)
        passTextFieldView.setReturnKeyType(returnKeyType: .next)
        passTextFieldView.textField.tag = 4
        passTextFieldView.editTextButton.setImage(UIImage(named: "eye"), for: UIControlState())
        passTextFieldView.editTextButton.tintColor = UIColor(netHex: placeholder_gray).withAlphaComponent(0.4)
        
        confirmPassTextFieldView.setTexColor(TextColor: UIColor.black)//(netHex: dark_red))
        confirmPassTextFieldView.setPlaceholder(Placeholder: "Confirm password", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        confirmPassTextFieldView.setSecureText(isSecureTextEntry: true)
        confirmPassTextFieldView.setReturnKeyType(returnKeyType: .default)
        confirmPassTextFieldView.textField.tag = 5
        confirmPassTextFieldView.editTextButton.setImage(UIImage(named: "eye"), for: UIControlState())
        confirmPassTextFieldView.editTextButton.tintColor = UIColor(netHex: placeholder_gray).withAlphaComponent(0.4)
        
        createAccountButton.backgroundColor = UIColor(netHex: mooviest_red)
        createAccountButton.setTitle(NSLocalizedString("createAccountButton", comment: "Title of createAccountButton"), for: UIControlState())
        createAccountButton.setTitleColor(UIColor.white, for: UIControlState())
        createAccountButton.layer.cornerRadius = 3
        
        backLoginButton.setTitle(NSLocalizedString("backloginButton", comment: "Title of backLoginButton"), for: UIControlState())
        backLoginButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: UIControlState())
        backLoginButton.alpha = 0.0
        
        formRegisterView.addSubview(padingRegisterformView)
        padingRegisterformView.addSubview(userTextFieldView)
        padingRegisterformView.addSubview(emailTextFieldView)
        padingRegisterformView.addSubview(passTextFieldView)
        padingRegisterformView.addSubview(confirmPassTextFieldView)
        padingRegisterformView.addSubview(createAccountButton)
        
        formView.addSubview(padingformView)
        padingformView.addSubview(userOrEmailTextFieldView)
        padingformView.addSubview(passLoginTextFieldView)
        padingformView.addSubview(loginButton)
        centralView.addSubview(formView)
        centralView.addSubview(formRegisterView)
        
        addSubview(backgroundStatusView)
        addSubview(titleImageView)
        addSubview(goCreateAccountFormButton)
        addSubview(backLoginButton)
        addSubview(centralView)
    }
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        centralView.translatesAutoresizingMaskIntoConstraints = false
        
        formView.translatesAutoresizingMaskIntoConstraints = false
        padingformView.translatesAutoresizingMaskIntoConstraints = false
        userOrEmailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        passLoginTextFieldView.translatesAutoresizingMaskIntoConstraints = false        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        goCreateAccountFormButton.translatesAutoresizingMaskIntoConstraints = false
        backLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        formRegisterView.translatesAutoresizingMaskIntoConstraints = false
        padingRegisterformView.translatesAutoresizingMaskIntoConstraints = false
        userTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        passTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        confirmPassTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        addConstraint(backLoginButton.bottomAnchor.constraint(equalTo: bottomAnchor))
        addConstraint(backLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(backLoginButton.widthAnchor.constraint(equalTo: formView.widthAnchor))
        addConstraint(backLoginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15))
        
        addConstraint(centralView.topAnchor.constraint(equalTo: titleImageView.bottomAnchor))
        addConstraint(centralView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(centralView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(centralView.bottomAnchor.constraint(equalTo: goCreateAccountFormButton.topAnchor))
        
        centralView.addConstraint(formView.centerYAnchor.constraint(equalTo: centralView.centerYAnchor))
        centralView.addConstraint(formView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        centralView.addConstraint(formView.widthAnchor.constraint(equalTo: centralView.widthAnchor,multiplier: 0.8))
        centralView.addConstraint(formView.heightAnchor.constraint(equalTo: centralView.heightAnchor, multiplier: 0.6))
        
        formView.addConstraint(padingformView.centerYAnchor.constraint(equalTo: formView.centerYAnchor))
        formView.addConstraint(padingformView.centerXAnchor.constraint(equalTo: formView.centerXAnchor))
        formView.addConstraint(padingformView.widthAnchor.constraint(equalTo: formView.widthAnchor, multiplier: 0.9))
        formView.addConstraint(padingformView.heightAnchor.constraint(equalTo: formView.heightAnchor, multiplier: 0.8))
        
        padingformView.addConstraint(userOrEmailTextFieldView.topAnchor.constraint(equalTo: padingformView.topAnchor))
        padingformView.addConstraint(userOrEmailTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(userOrEmailTextFieldView.widthAnchor.constraint(equalTo: padingformView.widthAnchor))
        padingformView.addConstraint(userOrEmailTextFieldView.heightAnchor.constraint(equalTo: padingformView.heightAnchor, multiplier: 0.35))
        
        padingformView.addConstraint(passLoginTextFieldView.topAnchor.constraint(equalTo: userOrEmailTextFieldView.bottomAnchor))
        padingformView.addConstraint(passLoginTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(passLoginTextFieldView.widthAnchor.constraint(equalTo: userOrEmailTextFieldView.widthAnchor))
        padingformView.addConstraint(passLoginTextFieldView.heightAnchor.constraint(equalTo: userOrEmailTextFieldView.heightAnchor))
        
        padingformView.addConstraint(loginButton.bottomAnchor.constraint(equalTo: padingformView.bottomAnchor))
        padingformView.addConstraint(loginButton.leftAnchor.constraint(equalTo: padingformView.leftAnchor))
        padingformView.addConstraint(loginButton.widthAnchor.constraint(equalTo: padingformView.widthAnchor))
        padingformView.addConstraint(loginButton.heightAnchor.constraint(equalTo: userOrEmailTextFieldView.heightAnchor,multiplier: 0.6))
        
        formRegisterViewCenterXAnchor = formRegisterView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor, constant: -800)
        formRegisterViewCenterYAnchor = formRegisterView.centerYAnchor.constraint(equalTo: centralView.centerYAnchor)
        centralView.addConstraint(formRegisterViewCenterYAnchor)
        centralView.addConstraint(formRegisterViewCenterXAnchor)
        centralView.addConstraint(formRegisterView.widthAnchor.constraint(equalTo: centralView.widthAnchor,multiplier: 0.8))
        centralView.addConstraint(formRegisterView.heightAnchor.constraint(equalTo: centralView.heightAnchor, multiplier: 0.9))

        formRegisterView.addConstraint(padingRegisterformView.centerYAnchor.constraint(equalTo: formRegisterView.centerYAnchor))
        formRegisterView.addConstraint(padingRegisterformView.centerXAnchor.constraint(equalTo: formRegisterView.centerXAnchor))
        formRegisterView.addConstraint(padingRegisterformView.widthAnchor.constraint(equalTo: formRegisterView.widthAnchor, multiplier: 0.9))
        formRegisterView.addConstraint(padingRegisterformView.heightAnchor.constraint(equalTo: formRegisterView.heightAnchor, multiplier: 0.85))

        padingRegisterformView.addConstraint(userTextFieldView.topAnchor.constraint(equalTo: padingRegisterformView.topAnchor))
        padingRegisterformView.addConstraint(userTextFieldView.centerXAnchor.constraint(equalTo: padingRegisterformView.centerXAnchor))
        padingRegisterformView.addConstraint(userTextFieldView.widthAnchor.constraint(equalTo: padingRegisterformView.widthAnchor))
        padingRegisterformView.addConstraint(userTextFieldView.heightAnchor.constraint(equalTo: padingRegisterformView.heightAnchor, multiplier: 0.22))
        
        padingRegisterformView.addConstraint(emailTextFieldView.topAnchor.constraint(equalTo: userTextFieldView.bottomAnchor))
        padingRegisterformView.addConstraint(emailTextFieldView.centerXAnchor.constraint(equalTo: padingRegisterformView.centerXAnchor))
        padingRegisterformView.addConstraint(emailTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingRegisterformView.addConstraint(emailTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))

        padingRegisterformView.addConstraint(passTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor))
        padingRegisterformView.addConstraint(passTextFieldView.centerXAnchor.constraint(equalTo: padingRegisterformView.centerXAnchor))
        padingRegisterformView.addConstraint(passTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingRegisterformView.addConstraint(passTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        padingRegisterformView.addConstraint(confirmPassTextFieldView.topAnchor.constraint(equalTo: passTextFieldView.bottomAnchor))
        padingRegisterformView.addConstraint(confirmPassTextFieldView.centerXAnchor.constraint(equalTo: padingRegisterformView.centerXAnchor))
        padingRegisterformView.addConstraint(confirmPassTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingRegisterformView.addConstraint(confirmPassTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        padingRegisterformView.addConstraint(createAccountButton.bottomAnchor.constraint(equalTo: padingRegisterformView.bottomAnchor))
        padingRegisterformView.addConstraint(createAccountButton.leftAnchor.constraint(equalTo: padingRegisterformView.leftAnchor))
        padingRegisterformView.addConstraint(createAccountButton.widthAnchor.constraint(equalTo: padingRegisterformView.widthAnchor))
        padingRegisterformView.addConstraint(createAccountButton.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor,multiplier: 0.6))
    }
    
    func seTextFieldsDelegate(Delegate d: UITextFieldDelegate){
        userOrEmailTextFieldView.setDelegate(Delegate: d)
        passLoginTextFieldView.setDelegate(Delegate: d)
        
        userTextFieldView.setDelegate(Delegate: d)
        emailTextFieldView.setDelegate(Delegate: d)
        passTextFieldView.setDelegate(Delegate: d)
        confirmPassTextFieldView.setDelegate(Delegate: d)
    }
    
    func adjustFontSizeToFitHeight () {
        userOrEmailTextFieldView.adjustFontSizeToFitHeight()
        passLoginTextFieldView.adjustFontSizeToFitHeight()
        userTextFieldView.adjustFontSizeToFitHeight()
        emailTextFieldView.adjustFontSizeToFitHeight()
        passTextFieldView.adjustFontSizeToFitHeight()
        confirmPassTextFieldView.adjustFontSizeToFitHeight()
    }
    
    func clearAllTextField() {
        userOrEmailTextFieldView.clearText()
        passLoginTextFieldView.clearText()
        userTextFieldView.clearText()
        emailTextFieldView.clearText()
        passTextFieldView.clearText()
        confirmPassTextFieldView.clearText()

    }
    
    func registerViewSetHidden(withDuration: TimeInterval, from: UIView , to: UIView) {
        
        self.superview!.layoutIfNeeded()
        UIView.animate(withDuration: withDuration, animations: {
                self.formRegisterViewCenterXAnchor.constant = to == self.goCreateAccountFormButton ? self.superview!.frame.size.width:0
                self.superview!.layoutIfNeeded()
            }, completion: { (value) in
                self.clearAllTextField()
                if self.formRegisterViewCenterXAnchor.constant > 0 {
//                    self.formRegisterViewCenterYAnchor.constant = self.superview!.frame.size.height
                    self.formRegisterViewCenterXAnchor.constant = -self.superview!.frame.size.width
                    self.formRegisterViewCenterYAnchor.constant = 0
                }
            }
        )
        from.transition(withDuration: withDuration, to: to)
    }
}

//Refactor extract outside
extension UIView {
    func transition(withDuration: TimeInterval, to:UIView) {
        UIView.animate(withDuration: withDuration/2, animations: {
            self.alpha = 0.0
            }, completion: { (value) in
                UIView.animate(withDuration: withDuration/2) {
                    to.alpha = 0.7
                }
            }
        )
    }
    
    func comeBackOrigin(withDuration: TimeInterval , moved: CGFloat) {
        UIView.animate(withDuration: withDuration) {
            self.frame.origin.y -= moved
        }
    }
    
}
