//
//  RegisterViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 16/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var v = RegisterView()
    var activeField:UITextField?
    var move = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        v.seTextFieldsDelegate(Delegate:self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.addSubview(v)
        
        v.backLoginButton.addTarget(self, action: #selector(self.backlogin), for: .touchUpInside)
        v.createAccountButton.addTarget(self, action: #selector(self.register), for: .touchUpInside)
        setupConstraints()
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
    
    //This method is called when the autolayout engine has finished to calculate your views' frames
    override func viewDidLayoutSubviews() {
        v.adjustFontSizeToFitHeight()
    }
    
    func register() {
        let user = v.userTextFieldView.getText()
        let pass = v.passTextFieldView.getText()
        let email = v.emailTextFieldView.getText()
        let langCode = "es" //sacar idioma del movil
        
        DataModel.sharedInstance.register(Username: user, Password: pass, Email: email, Lang: langCode) {
            (data) in
            print("resgister")
            print(data)
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func backlogin() {
       _ = self.navigationController?.popViewController(animated: true)
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
            if textField == v.confirmPassTextFieldView.textField {
                register()
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
