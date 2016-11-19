//
//  EditProfileView.swift
//  Mooviest
//
//  Created by Antonio RG on 10/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class EditProfileView: UIView {
    
    let height = UIApplication.shared.statusBarFrame.size.height
    var backgroundStatusView = UIView()
    
    var heightNavBar:CGFloat!
    var headerView = UIView()
    let lineView = UIView()
    
    var centralView = UIScrollView()
    var topView = UIView()
    var coverImageView = UIImageView()
    
    let userTextFieldView = TextFieldView()
    let firstNameTextFieldView = TextFieldView()
    let lastNameTextFieldView = TextFieldView()
    let emailTextFieldView = TextFieldView()
    let dateTextFieldView = TextFieldView()
    let genderTextFieldView = TextFieldView()
    let countryTextFieldView = TextFieldView()
    
    var clearTextButton:UIButton!
    var photoButton = UIButton(type: UIButtonType.system) as UIButton

    init(heightNavBar h: CGFloat) {
        super.init(frame: CGRect.zero)
        heightNavBar = h
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        self.backgroundColor = UIColor.white
        backgroundStatusView.backgroundColor =   UIColor.white.withAlphaComponent(0.2)
        headerView.backgroundColor = barTintColor
        headerView.clipsToBounds = true
        lineView.backgroundColor = UIColor.lightGray
        
        topView.backgroundColor = .white
        coverImageView.image = UIImage(named: "contact")
        coverImageView.backgroundColor = UIColor.white
        coverImageView.contentMode = UIViewContentMode.scaleAspectFill
        coverImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        coverImageView.layer.borderWidth = 1.8
        coverImageView.layer.masksToBounds = true
        
        let placeholderUser = NSLocalizedString("placeholderUser", comment: "Placeholder of userTextFieldView")
        userTextFieldView.setTexColor(TextColor: UIColor.black)
        userTextFieldView.setPlaceholder(Placeholder: placeholderUser, PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        userTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        userTextFieldView.setReturnKeyType(returnKeyType: .next)
        userTextFieldView.textField.tag = 0
        
        let placeholderFirstName = NSLocalizedString("placeholderFirstName", comment: "Placeholder of firstNameTextFieldView")
        firstNameTextFieldView.setTexColor(TextColor: UIColor.black)
        firstNameTextFieldView.setPlaceholder(Placeholder: placeholderFirstName, PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        firstNameTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        firstNameTextFieldView.setReturnKeyType(returnKeyType: .next)
        firstNameTextFieldView.setAutocapitalizationType(autocapitalizationType: .words)
        firstNameTextFieldView.textField.tag = 1
        
        let placeholderLastName = NSLocalizedString("placeholderLastName", comment: "Placeholder of lastNameTextFieldView")
        lastNameTextFieldView.setTexColor(TextColor: UIColor.black)
        lastNameTextFieldView.setPlaceholder(Placeholder: placeholderLastName, PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        lastNameTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        lastNameTextFieldView.setReturnKeyType(returnKeyType: .next)
        lastNameTextFieldView.setAutocapitalizationType(autocapitalizationType: .words)
        lastNameTextFieldView.textField.tag = 2
        
        let placeholderEmail = NSLocalizedString("placeholderEmail", comment: "Placeholder of emailTextFieldView")
        emailTextFieldView.setTexColor(TextColor: UIColor.black)
        emailTextFieldView.setPlaceholder(Placeholder: placeholderEmail, PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        emailTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.emailAddress)
        emailTextFieldView.setReturnKeyType(returnKeyType: .next)
        emailTextFieldView.textField.tag = 3
        
        let placeholderDate = NSLocalizedString("placeholderDate", comment: "Placeholder of dateTextFieldView")
        dateTextFieldView.setTexColor(TextColor: UIColor.black)
        dateTextFieldView.setPlaceholder(Placeholder: placeholderDate, PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        dateTextFieldView.setReturnKeyType(returnKeyType: .next)
        dateTextFieldView.textField.tag = 4
        dateTextFieldView.textField.isSelected = false
        
        let placeholderGender = NSLocalizedString("placeholderGender", comment: "Placeholder of genderTextFieldView")
        genderTextFieldView.setTexColor(TextColor: UIColor.black)
        genderTextFieldView.setPlaceholder(Placeholder: placeholderGender, PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        genderTextFieldView.setReturnKeyType(returnKeyType: .next)
        genderTextFieldView.textField.tag = 5
        genderTextFieldView.textField.isSelected = false
        
        let placeholderCountry = NSLocalizedString("placeholderCountry", comment: "Placeholder of countryTextFieldView")
        countryTextFieldView.setTexColor(TextColor: UIColor.black)
        countryTextFieldView.setPlaceholder(Placeholder: placeholderCountry, PlaceholderColor:   placeholder_gray.withAlphaComponent(0.7))
        countryTextFieldView.setReturnKeyType(returnKeyType: .send)
        countryTextFieldView.textField.tag = 6
        countryTextFieldView.textField.isSelected = false
        
        photoButton.setImage(UIImage(named: "camera"), for: UIControlState())
        photoButton.tintColor =   mooviest_red
        photoButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        clearTextButton = UIButton(type: UIButtonType.system) as UIButton
        clearTextButton.setImage(UIImage(named: "clear"), for: UIControlState())
        clearTextButton.contentMode = .scaleToFill
        clearTextButton.tintColor = .gray

        topView.addSubview(coverImageView)
        topView.addSubview(photoButton)
        
        centralView.addSubview(userTextFieldView)
        centralView.addSubview(firstNameTextFieldView)
        centralView.addSubview(lastNameTextFieldView)
        centralView.addSubview(emailTextFieldView)
        centralView.addSubview(dateTextFieldView)
        centralView.addSubview(genderTextFieldView)
        centralView.addSubview(countryTextFieldView)
        
        addSubview(centralView)
        addSubview(topView)        
        addSubview(headerView)
        addSubview(lineView)
        addSubview(backgroundStatusView)
    } 
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        centralView.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        userTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        dateTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        genderTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        countryTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
        addConstraint(lineView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(lineView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(lineView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(lineView.heightAnchor.constraint(equalToConstant: 0.5))
        
        addConstraint(topView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(topView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(topView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(topView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4))
        
        topView.addConstraint(coverImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor))
        topView.addConstraint(coverImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor))
        topView.addConstraint(coverImageView.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.8))
        topView.addConstraint(coverImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.8))
        
        topView.addConstraint(photoButton.centerXAnchor.constraint(equalTo: topView.centerXAnchor))
        topView.addConstraint(photoButton.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor))
        topView.addConstraint(photoButton.widthAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 0.3))
        topView.addConstraint(photoButton.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 0.3))
        
        addConstraint(centralView.topAnchor.constraint(equalTo: topView.bottomAnchor))
        addConstraint(centralView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(centralView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(centralView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        addConstraint(userTextFieldView.topAnchor.constraint(equalTo: topView.bottomAnchor))
        addConstraint(userTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(userTextFieldView.widthAnchor.constraint(equalTo: centralView.widthAnchor, multiplier:0.8))
        addConstraint(userTextFieldView.heightAnchor.constraint(equalTo: centralView.heightAnchor, multiplier: 1/7))
        
        addConstraint(firstNameTextFieldView.topAnchor.constraint(equalTo: userTextFieldView.bottomAnchor))
        addConstraint(firstNameTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(firstNameTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        addConstraint(firstNameTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        addConstraint(lastNameTextFieldView.topAnchor.constraint(equalTo: firstNameTextFieldView.bottomAnchor))
        addConstraint(lastNameTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(lastNameTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        addConstraint(lastNameTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        addConstraint(emailTextFieldView.topAnchor.constraint(equalTo: lastNameTextFieldView.bottomAnchor))
        addConstraint(emailTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(emailTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        addConstraint(emailTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        addConstraint(dateTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor))
        addConstraint(dateTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(dateTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        addConstraint(dateTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        addConstraint(dateTextFieldView.topAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor))
        addConstraint(dateTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(dateTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        addConstraint(dateTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))

        addConstraint(genderTextFieldView.topAnchor.constraint(equalTo: dateTextFieldView.bottomAnchor))
        addConstraint(genderTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(genderTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        addConstraint(genderTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        addConstraint(countryTextFieldView.topAnchor.constraint(equalTo: genderTextFieldView.bottomAnchor))
        addConstraint(countryTextFieldView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        addConstraint(countryTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        addConstraint(countryTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
    }
    
    func seTextFieldsDelegate(Delegate d: UITextFieldDelegate){        
        userTextFieldView.setDelegate(Delegate: d)
        emailTextFieldView.setDelegate(Delegate: d)
        firstNameTextFieldView.setDelegate(Delegate: d)
        lastNameTextFieldView.setDelegate(Delegate: d)
        genderTextFieldView.setDelegate(Delegate: d)
        dateTextFieldView.setDelegate(Delegate: d)
        countryTextFieldView.setDelegate(Delegate: d)
        let heightTextField = userTextFieldView.textField.frame.height
        clearTextButton.frame.size = CGSize(width: heightTextField, height: heightTextField)        
    }
    
    func adjustFontSizeToFitHeight () {
        userTextFieldView.adjustFontSizeToFitHeight()
        emailTextFieldView.adjustFontSizeToFitHeight()
        firstNameTextFieldView.adjustFontSizeToFitHeight()
        lastNameTextFieldView.adjustFontSizeToFitHeight()
        genderTextFieldView.adjustFontSizeToFitHeight()
        dateTextFieldView.adjustFontSizeToFitHeight()
        countryTextFieldView.adjustFontSizeToFitHeight()
        let heightTextField = userTextFieldView.textField.frame.height
        clearTextButton.frame.size = CGSize(width: heightTextField, height: heightTextField)
    }
}
