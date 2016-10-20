//
//  EditProfileViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 10/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher

class EditProfileViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //offset for animation
    var offset_HeaderStop:CGFloat!
    var offset_CoverStopScale:CGFloat!
    var offset_CardProfileStop:CGFloat!
    var offset_BackdropFadeOff:CGFloat!
    
    var user:User?
    var picker:UIImagePickerController!
    var height:CGFloat!
    var v: EditProfileView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        height = self.navigationController?.navigationBar.frame.height
        v = EditProfileView(heightNavBar: height)
        setupView()
        view.addSubview(v)
        setupConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        picker = UIImagePickerController()
        picker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDataView()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        v.coverImageView.contentMode = .scaleToFill //3
        v.coverImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func photoPicker() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func setupView() {
        let cornerRadius = view.frame.size.width*0.2
        v.coverImageView.layer.cornerRadius = cornerRadius
        v.coverImageView.layer.masksToBounds = true
        v.backgroundPhotoButtonView.layer.cornerRadius = cornerRadius*0.3
        let saveButton = UIBarButtonItem(image: UIImage(named: "save"),
                                         style: UIBarButtonItemStyle.plain ,
                                         target: self, action: #selector(self.saveProfile))
        saveButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = saveButton
        v.photoButton.addTarget(self, action: #selector(self.photoPicker), for: .touchUpInside)
        if let avatar = user?.avatar {
            v.coverImageView.kf_setImage(with: URL(string: "\(DataModel.sharedInstance.path)\(avatar)"),placeholder: UIImage(named: "contact"))
        }
    }
    
    func loadDataView() {
        v.userTextFieldView.textField.text = user?.username
        v.firstNameTextFieldView.textField.text = user?.firstname
        v.lastNameTextFieldView.textField.text = user?.lastname
        v.emailTextFieldView.textField.text = user?.email
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
    
    func saveProfile(){
        user?.username = v.userTextFieldView.getText()
        user?.firstname = v.firstNameTextFieldView.getText()
        user?.lastname = v.lastNameTextFieldView.getText()
        user?.email = v.emailTextFieldView.getText()
        
        DataModel.sharedInstance.updateUser(user: user!,avatar: v.coverImageView.image!){
            (successful, message, user) in
            if successful {
                self.user = user
                Message.msgPopupDelay(title: "", message: "Update successful", delay: 1, ctrl: self){}                    
            } else {
                Message.msgPopupDelay(title: "Error update data", message: message, delay: 0, ctrl: self) {}
            }
        }
    
    }
}
