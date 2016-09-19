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
    var textColor:UIColor!
    var placeholderColor:UIColor!
    
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
        
        addSubview(textField)
        addSubview(lineView)
    }
    
    func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(textField.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(textField.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(textField.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4))
        
        addConstraint(lineView.topAnchor.constraint(equalTo: textField.bottomAnchor))
        addConstraint(lineView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(lineView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(lineView.heightAnchor.constraint(equalToConstant: 1))
    }
    
    func setTexColor(TextColor c: UIColor) {
        self.textColor = c
        textField.textColor = c
    }
    
    func setPlaceholder(Placeholder t: String, PlaceholderColor c: UIColor) {
        self.placeholderColor = c
        textField.attributedPlaceholder = NSAttributedString(string: t, attributes: [NSForegroundColorAttributeName : c.withAlphaComponent(0.5) ])
        lineView.backgroundColor = c
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
        self.textField.font =  UIFont(name: self.textField.font!.fontName, size:self.textField.frame.size.height*0.7)!
    }
}
