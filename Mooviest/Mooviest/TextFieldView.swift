//
//  TextFieldView.swift
//  Mooviest
//
//  Created by Antonio RG on 17/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    
    var textField = UITextField()
    var lineView = UIView()
    var errorLabel = UILabel()
    let placeholderLabel = UILabel()
    var textColor:UIColor!
    var placeholderColor:UIColor!
    var lineViewHeightAnchor:NSLayoutConstraint!
    
    init() {
        super.init(frame: CGRect.zero)
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupComponents() {
        textField.autocorrectionType = .no // autocorreccion
        textField.autocapitalizationType = .none //La primera mayuscula
        textField.spellCheckingType = .no //correcion ortografica
        textField.enablesReturnKeyAutomatically = true

        errorLabel.text = ""
        errorLabel.textColor = mooviest_red
        errorLabel.textAlignment = .right
        
        placeholderLabel.text = "Prueba"
        placeholderLabel.textColor = mooviest_red
        placeholderLabel.textAlignment = .left
        placeholderLabel.alpha = 0
        
        addSubview(textField)
        addSubview(lineView)
        addSubview(errorLabel)
        addSubview(placeholderLabel)
    }
    
    func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(textField.topAnchor.constraint(equalTo: errorLabel.bottomAnchor))
        addConstraint(textField.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(textField.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4))
        
        addConstraint(errorLabel.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor))
        addConstraint(errorLabel.rightAnchor.constraint(equalTo: textField.rightAnchor))
        addConstraint(errorLabel.widthAnchor.constraint(equalTo: textField.widthAnchor))
        addConstraint(errorLabel.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.5))
        
        addConstraint(placeholderLabel.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(placeholderLabel.leftAnchor.constraint(equalTo: textField.leftAnchor))
        addConstraint(placeholderLabel.widthAnchor.constraint(equalTo: textField.widthAnchor))
        addConstraint(placeholderLabel.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.5))
        
        lineViewHeightAnchor = lineView.heightAnchor.constraint(equalToConstant: 1)
        addConstraint(lineView.topAnchor.constraint(equalTo: textField.bottomAnchor))
        addConstraint(lineView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(lineView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(lineViewHeightAnchor)
    }
    
    func setTexColor(TextColor c: UIColor) {
        self.textColor = c
        textField.textColor = c
    }
    
    func setPlaceholder(Placeholder t: String, PlaceholderColor c: UIColor) {
        self.placeholderColor = c
        textField.attributedPlaceholder = NSAttributedString(string: t, attributes: [NSForegroundColorAttributeName : c.withAlphaComponent(0.5) ])
        lineView.backgroundColor = c
        placeholderLabel.text = t
    }
    
    func setSecureText(isSecureTextEntry s: Bool){
        textField.isSecureTextEntry = s
    }
    
    func getText()->String {
        return textField.text!
    }
    
    func setKeyboardType(KeyboardType t: UIKeyboardType){
        textField.keyboardType = t
    }
    
    func setReturnKeyType(returnKeyType t: UIReturnKeyType){
        textField.returnKeyType = t
    }
    
    func setDelegate(Delegate d: UITextFieldDelegate){
        textField.delegate = d
    }
 
    func adjustFontSizeToFitHeight () {
        textField.font =  UIFont(name: self.textField.font!.fontName, size:self.textField.frame.size.height*0.7)!
        errorLabel.font = UIFont(name: self.errorLabel.font!.fontName, size:self.errorLabel.frame.size.height)!
        placeholderLabel.font = UIFont(name: self.placeholderLabel.font!.fontName, size:self.placeholderLabel.frame.size.height)!
    }
    
    func clearText() {
        textField.text = nil
        errorLabel.text = nil
    }
    
    func setErrorText(message:String) {
        errorLabel.text = message
    }
    
    func setAutocapitalizationType(autocapitalizationType t: UITextAutocapitalizationType){
        textField.autocapitalizationType = t
    }
    
    func didBeginEditing() {
        lineView.backgroundColor = mooviest_red
        placeholderLabel.alpha = 1
        lineViewHeightAnchor.constant = 2
    }
    
    func didEndEditing() {
        lineView.backgroundColor = placeholderColor
        placeholderLabel.alpha = 0
        lineViewHeightAnchor.constant = 1
    }
    
}
