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
            textField.rightView = v.secureTextButton;
            textField.rightViewMode = UITextFieldViewMode.always
        } else {
            textField.rightView = v.clearTextButton;
            textField.rightViewMode = UITextFieldViewMode.always
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            let nextTag: NSInteger = textField.tag + 1;
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
            textField.rightView?.tintColor = UIColor(netHex: placeholder_gray).withAlphaComponent(textField.isSecureTextEntry ? 0.4:0.9)
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
    
    func msgPopupDelay(Title t: String, Message m:String, Delay s: Double, okTapped: @escaping ()->Void) {
        
        let alertController = UIAlertController(title: t, message: m, preferredStyle: .alert)
        if s > 0 {
        
            
            DispatchQueue.main.asyncAfter(deadline: .now() + s) {
                alertController.dismiss(animated: true, completion: nil)
                okTapped()
            }
        } else {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                okTapped()
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func register() {
        if validateFormRegister() {
            let user = v.userTextFieldView.getText()
            let pass = v.passTextFieldView.getText()
            let email = v.emailTextFieldView.getText()
            let langCode = "es" //sacar idioma del movil
            
            DataModel.sharedInstance.register(Username: user, Password: pass, Email: email, Lang: langCode) {
                (data) in
                print("resgister")
                //menssage emergente Success register
                do {
                    DataModel.sharedInstance.user = try User(json: data)
                    self.msgPopupDelay(Title: "Confirm", Message: "Register successful", Delay: 1){
                        self.hiddenFormRegister()
                    }
                    
                } catch {
                    DataModel.sharedInstance.user = nil
                    //error login
                    self.msgPopupDelay(Title: "Register error", Message: "Ha ocurrido algún error", Delay: 0) {
                    }
                }
            }
        
        } else {
            //Menssage emergente de error
            self.msgPopupDelay(Title: "Register error", Message: "Error data form", Delay: 0) {
        
            }

        }
    }
    
    func login() {
        let user = v.userOrEmailTextFieldView.getText()
        let pass = v.passLoginTextFieldView.getText()
        
        
        DataModel.sharedInstance.login(Username: user, Password: pass) {
            (data) in
            print(data)
            do {
                DataModel.sharedInstance.user = try User(json: data)
                self.msgPopupDelay(Title: "", Message: "Login successful", Delay: 1){
                    self.chargueApp()
                }
            } catch {
               DataModel.sharedInstance.user = nil
                print(data)
                //error login
                let msg = data["message"] as? String
                self.msgPopupDelay(Title: "Register error", Message: msg == nil ? "Ha ocurrido algún error":msg!, Delay: 0) {
                }
            
            }
           
        }
       
    }
    
    func chargueApp() {
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
        nVController1.navigationBar.topItem?.titleView = UIImageView(image: UIImage(named: "title")!.withRenderingMode(.alwaysOriginal))
        nVController1.navigationBar.barTintColor = UIColor(netHex: mooviest_red)
        nVController1.navigationItem.backBarButtonItem = nil
        nVController1.navigationBar.barStyle = UIBarStyle.black


        tabBarController.viewControllers = [nVController1, tab2, tab3]

        UITabBar.appearance().barTintColor = UIColor(netHex: mooviest_red)
        UITabBar.appearance().tintColor = UIColor.white

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
