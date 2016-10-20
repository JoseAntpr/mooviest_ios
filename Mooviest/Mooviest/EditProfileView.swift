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
    
    var centralView = UIView()
    var topView = UIView()
    var coverImageView = UIImageView()
    
    var formView = UIView()
    var padingformView = UIView()
    
    var userTextFieldView = TextFieldView()
    var firstNameTextFieldView = TextFieldView()
    var lastNameTextFieldView = TextFieldView()
    var emailTextFieldView = TextFieldView()
    
    var backgroundPhotoButtonView = UIView()
    var photoButton = UIButton(type: UIButtonType.system) as UIButton
    
//    var clearTextButton:UIButton!
//    var secureTextButton:UIButton!

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
        backgroundStatusView.backgroundColor = UIColor(netHex: dark_gray).withAlphaComponent(0.5)
        headerView.backgroundColor = UIColor(netHex: mooviest_red)
        headerView.clipsToBounds = true
        
        topView.backgroundColor = .white
        coverImageView.image = UIImage(named: "contact")
        coverImageView.backgroundColor = UIColor.white
        coverImageView.contentMode = UIViewContentMode.scaleToFill
        coverImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        coverImageView.layer.borderWidth = 1.8
        coverImageView.layer.masksToBounds = true
        
        userTextFieldView.setTexColor(TextColor: UIColor.black)
        userTextFieldView.setPlaceholder(Placeholder: "Username", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        userTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        userTextFieldView.setReturnKeyType(returnKeyType: .next)
//        userTextFieldView.textField.tag = TextFieldViewTag.UserTextFieldView.rawValue
        
        firstNameTextFieldView.setTexColor(TextColor: UIColor.black)
        firstNameTextFieldView.setPlaceholder(Placeholder: "First name", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        firstNameTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        firstNameTextFieldView.setReturnKeyType(returnKeyType: .next)
        firstNameTextFieldView.setAutocapitalizationType(autocapitalizationType: .words)
//        firstNameTextFieldView.textField.tag = TextFieldViewTag.PassTextFieldView.rawValue
        
        lastNameTextFieldView.setTexColor(TextColor: UIColor.black)
        lastNameTextFieldView.setPlaceholder(Placeholder: "Last name", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        lastNameTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.alphabet)
        lastNameTextFieldView.setReturnKeyType(returnKeyType: .next)
        lastNameTextFieldView.setAutocapitalizationType(autocapitalizationType: .words)
//        lastNameTextFieldView.textField.tag = TextFieldViewTag.ConfirmPassTextFieldView.rawValue
        
        emailTextFieldView.setTexColor(TextColor: UIColor.black)
        emailTextFieldView.setPlaceholder(Placeholder: "Email", PlaceholderColor: UIColor(netHex: placeholder_gray).withAlphaComponent(0.7))
        emailTextFieldView.setKeyboardType(KeyboardType: UIKeyboardType.emailAddress)
        emailTextFieldView.setReturnKeyType(returnKeyType: .next)
//        emailTextFieldView.textField.tag = TextFieldViewTag.EmailTextFieldView.rawValue
        
        backgroundPhotoButtonView.backgroundColor = UIColor(netHex: mooviest_red)
        photoButton.setImage(UIImage(named: "camera"), for: UIControlState())
        photoButton.tintColor = .white
        
        backgroundPhotoButtonView.addSubview(photoButton)
        topView.addSubview(coverImageView)
        topView.addSubview(backgroundPhotoButtonView)
        
        padingformView.addSubview(userTextFieldView)
        padingformView.addSubview(firstNameTextFieldView)
        padingformView.addSubview(lastNameTextFieldView)
        padingformView.addSubview(emailTextFieldView)
        
        formView.addSubview(padingformView)
        centralView.addSubview(formView)
        
        addSubview(topView)
        addSubview(centralView)
        addSubview(headerView)
        addSubview(backgroundStatusView)
    } 
    
    func setupConstraints() {
        backgroundStatusView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        centralView.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        formView.translatesAutoresizingMaskIntoConstraints = false
        padingformView.translatesAutoresizingMaskIntoConstraints = false
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        userTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundPhotoButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(backgroundStatusView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(backgroundStatusView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(backgroundStatusView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(backgroundStatusView.heightAnchor.constraint(equalToConstant: height))
        
        addConstraint(headerView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(headerView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(headerView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(headerView.heightAnchor.constraint(equalToConstant: height + heightNavBar))
        
        addConstraint(topView.topAnchor.constraint(equalTo: headerView.bottomAnchor))
        addConstraint(topView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(topView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(topView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5))
        
        topView.addConstraint(coverImageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor))
        topView.addConstraint(coverImageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor))
        topView.addConstraint(coverImageView.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.8))
        topView.addConstraint(coverImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.8))
        
        topView.addConstraint(backgroundPhotoButtonView.centerXAnchor.constraint(equalTo: topView.centerXAnchor))
        topView.addConstraint(backgroundPhotoButtonView.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor))
        topView.addConstraint(backgroundPhotoButtonView.widthAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 0.3))
        topView.addConstraint(backgroundPhotoButtonView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 0.3))
        
        backgroundPhotoButtonView.addConstraint(photoButton.centerXAnchor.constraint(equalTo: backgroundPhotoButtonView.centerXAnchor))
        backgroundPhotoButtonView.addConstraint(photoButton.centerYAnchor.constraint(equalTo: backgroundPhotoButtonView.centerYAnchor))
        backgroundPhotoButtonView.addConstraint(photoButton.widthAnchor.constraint(equalTo: backgroundPhotoButtonView.widthAnchor, multiplier: 0.6))
        backgroundPhotoButtonView.addConstraint(photoButton.heightAnchor.constraint(equalTo: backgroundPhotoButtonView.widthAnchor, multiplier: 0.6))
        
        addConstraint(centralView.topAnchor.constraint(equalTo: topView.bottomAnchor))
        addConstraint(centralView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(centralView.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(centralView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        centralView.addConstraint(formView.topAnchor.constraint(equalTo: centralView.topAnchor))
        centralView.addConstraint(formView.centerXAnchor.constraint(equalTo: centralView.centerXAnchor))
        centralView.addConstraint(formView.widthAnchor.constraint(equalTo: centralView.widthAnchor,multiplier: 0.9))
        centralView.addConstraint(formView.heightAnchor.constraint(equalTo: centralView.heightAnchor, multiplier: 0.8))
        
        formView.addConstraint(padingformView.centerYAnchor.constraint(equalTo: formView.centerYAnchor))
        formView.addConstraint(padingformView.centerXAnchor.constraint(equalTo: formView.centerXAnchor))
        formView.addConstraint(padingformView.widthAnchor.constraint(equalTo: formView.widthAnchor, multiplier: 0.9))
        formView.addConstraint(padingformView.heightAnchor.constraint(equalTo: formView.heightAnchor, multiplier: 0.9))
        
        padingformView.addConstraint(userTextFieldView.topAnchor.constraint(equalTo: padingformView.topAnchor))
        padingformView.addConstraint(userTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(userTextFieldView.widthAnchor.constraint(equalTo: padingformView.widthAnchor))
        padingformView.addConstraint(userTextFieldView.heightAnchor.constraint(equalTo: padingformView.heightAnchor, multiplier: 0.25))
        
        padingformView.addConstraint(firstNameTextFieldView.topAnchor.constraint(equalTo: userTextFieldView.bottomAnchor))
        padingformView.addConstraint(firstNameTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(firstNameTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingformView.addConstraint(firstNameTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        padingformView.addConstraint(lastNameTextFieldView.topAnchor.constraint(equalTo: firstNameTextFieldView.bottomAnchor))
        padingformView.addConstraint(lastNameTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(lastNameTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingformView.addConstraint(lastNameTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
        
        padingformView.addConstraint(emailTextFieldView.topAnchor.constraint(equalTo: lastNameTextFieldView.bottomAnchor))
        padingformView.addConstraint(emailTextFieldView.centerXAnchor.constraint(equalTo: padingformView.centerXAnchor))
        padingformView.addConstraint(emailTextFieldView.widthAnchor.constraint(equalTo: userTextFieldView.widthAnchor))
        padingformView.addConstraint(emailTextFieldView.heightAnchor.constraint(equalTo: userTextFieldView.heightAnchor))
    }
    
//    func adjustConerRadius(){
//        coverImageView.layer.cornerRadius = coverImageView.frame.width/2
//    }
}
