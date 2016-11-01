//
//  LoginViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 3/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate, TabBarProtocol {
    
    var v = LoginView()
    var activeField:UITextField?
    var move = CGFloat(0)
    let secureArrayTag = [TextFieldViewTag.PassLoginTextFieldView.rawValue,
                       TextFieldViewTag.PassTextFieldView.rawValue,
                       TextFieldViewTag.ConfirmPassTextFieldView.rawValue]
    let USERNAME_MAX_LENGTH = 30
    let USERNAME_MIN_LENGTH = 5
    let PASS_MAX_LENGTH = 30
    let PASS_MIN_LENGTH = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEvents()
        v.seTextFieldsDelegate(Delegate: self)
        view.addSubview(v)
        setupConstraints()
    }
    
    //This method is called when the autolayout engine has finished to calculate your views' frames
    override func viewDidLayoutSubviews() {
        v.adjustFontSizeToFitHeight()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetTabBarAndNavigationController(viewController: self)
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }

    func setupEvents() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        v.goCreateAccountFormButton.addTarget(self, action: #selector(self.showFormRegister), for: .touchUpInside)
        v.backLoginButton.addTarget(self, action: #selector(self.hiddenFormRegister), for: .touchUpInside)
        
        v.passTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        v.confirmPassTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        v.userTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        v.emailTextFieldView.textField.addTarget(self, action: #selector(self.didChangeText(textField:)), for: .editingChanged)
        
        v.clearTextButton.addTarget(self, action: #selector(self.textClear(button:)), for: .touchUpInside)
        v.secureTextButton.addTarget(self, action: #selector(self.changeSecureText(button:)), for: .touchUpInside)
        
        v.loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        v.createAccountButton.addTarget(self, action: #selector(self.register), for: .touchUpInside)
    }
    
    // keyboard
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let view = sender.view
            let loc = sender.location(in: view)
            let subview = view?.hitTest(loc, with: nil)
            if subview != v.formView && subview != v.formRegisterView
                && subview != v.padingformView && subview != v.padingRegisterformView {
                self.view.endEditing(true)
            }
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        print("exit keyboard")
    }
    
    func keyboardWillShow(notification: NSNotification) {
        //Si queda el textfield tapado por el teclado movemos el form para que se vea
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if let origin = self.activeField?.convert((activeField?.frame.origin)!, from: self.view) {
                let positionEnd = self.view.frame.size.height - keyboardSize.height - activeField!.frame.height
                if origin.y + positionEnd < 0 {
                    let form = activeField!.superview?.superview == v.formView ? v.formView:v.formRegisterView
                    move = positionEnd + (origin.y)
                    form.frame.origin.y += self.move
                }
            }
        }
    }
    
    //TextField UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        let form = textField.superview?.superview == v.formView ? v.formView:v.formRegisterView
        form.comeBackOrigin(withDuration: 0.3, moved: move)
        move = 0
        activeField = nil
        textField.rightView = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        if secureArrayTag.index(of: textField.tag) != nil {
            textField.rightView = v.secureTextButton
            textField.rightViewMode = UITextFieldViewMode.always
        } else {
            textField.rightView = v.clearTextButton
            textField.rightViewMode = UITextFieldViewMode.always
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            let nextTag: NSInteger = textField.tag + 1
            // Try to find next responder
            if let nextResponder: UIResponder? = self.view.viewWithTag(nextTag){
                nextResponder?.becomeFirstResponder()
            }
        case .join:
            login()
            textField.resignFirstResponder()
        case .default:
            textField.resignFirstResponder()
            register()
        default:
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    //Show and hidden register form
    func showFormRegister(){
        registerViewSetHidden(withDuration: 0.4, from: v.goCreateAccountFormButton, to: v.backLoginButton)
    }
    
    func hiddenFormRegister() {
        registerViewSetHidden(withDuration: 0.4, from: v.backLoginButton, to: v.goCreateAccountFormButton)
    }
    
    func didChangeText(textField: UITextField) {
        switch textField.tag {
        case TextFieldViewTag.UserTextFieldView.rawValue:
            _ = v.userTextFieldView.validateNumberOfCharacters(minLength: USERNAME_MIN_LENGTH, maxLength: USERNAME_MAX_LENGTH)
        case TextFieldViewTag.EmailTextFieldView.rawValue:
            _ = v.emailTextFieldView.validateEmail()
        case TextFieldViewTag.PassTextFieldView.rawValue:
            _ = v.passTextFieldView.validateNumberOfCharacters(minLength: 4, maxLength: 30)
        case TextFieldViewTag.ConfirmPassTextFieldView.rawValue:
            _ = v.confirmPassTextFieldView.validateTextEqualTo(TextFieldView: v.passTextFieldView)
        default: break
        }
    }
    
    func validateFormRegister()->Bool {
        return v.userTextFieldView.validateNumberOfCharacters(minLength: USERNAME_MIN_LENGTH, maxLength: USERNAME_MAX_LENGTH)
            && v.passTextFieldView.validateNumberOfCharacters(minLength: PASS_MIN_LENGTH, maxLength: PASS_MAX_LENGTH) && v.confirmPassTextFieldView.validateTextEqualTo(TextFieldView: v.passTextFieldView)
    }
    
    
    func textClear(button: UIButton) {
        if let view = button.superview!.superview as? TextFieldView {
            view.clearText()
        }
    }
    
    func changeSecureText(button: UIButton) {
        if let textField = button.superview as? UITextField {
            textField.isSecureTextEntry = !textField.isSecureTextEntry
            button.setImage(UIImage(named: textField.isSecureTextEntry ? "eye" : "eye_off"), for: UIControlState())
        }
    }
    
    func registerViewSetHidden(withDuration: TimeInterval, from: UIView , to: UIView) {
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: withDuration, animations: {
            self.v.formRegisterViewCenterXAnchor.constant = to == self.v.goCreateAccountFormButton ? self.view.frame.size.width:0
            self.view.layoutIfNeeded()
            }, completion: { (value) in
                self.v.clearAllTextField()
                if self.v.formRegisterViewCenterXAnchor.constant > 0 {
                    self.v.formRegisterViewCenterXAnchor.constant = -self.view.frame.size.width
                    self.v.formRegisterViewCenterYAnchor.constant = 0
                }
            }
        )
        from.transition(withDuration: withDuration, to: to)
    }
    
    func register() {
        if validateFormRegister() {
            let user = v.userTextFieldView.getText()
            let pass = v.passTextFieldView.getText()
            let email = v.emailTextFieldView.getText()
            v.activityView.startAnimating()
            DataModel.sharedInstance.register(Username: user, Password: pass, Email: email) {
                (data) in
                //menssage emergente Success register
                do {
                    DataModel.sharedInstance.authenticationUser = try Authentication(json: data)
                    self.v.activityView.stopAnimating()
                    Message.msgPopupDelay(title: "Confirm", message: "Register successful", delay: 1, ctrl: self){
                        self.hiddenFormRegister()
                    }
                    
                } catch {
                    DataModel.sharedInstance.user = nil
                    //error login
                    Message.msgPopupDelay(title: "Register error", message: "Ha ocurrido algún error", delay: 0,ctrl: self) {
                    }
                }
            }
        } else {
            //Menssage emergente de error
            Message.msgPopupDelay(title: "Register error", message: "Error data form", delay: 0, ctrl: self) {
            }
        }
    }
    
    func login() {
        let user = v.userOrEmailTextFieldView.getText()
        let pass = v.passLoginTextFieldView.getText()
        v.activityView.startAnimating()
        DataModel.sharedInstance.login(Username: user, Password: pass) {
            (successful,message) in
            self.v.activityView.stopAnimating()
            if successful {
                self.chargueApp()                
            } else {
                Message.msgPopupDelay(title: "Login error", message: message == nil ? "Ha ocurrido algún error":message!, delay: 0, ctrl: self) {}
            }
        }       
    }
    
    func chargueApp() {
        let tabBarController = AnimatedTabBarController()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
