//
//  EditProfileViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 10/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher



class EditProfileViewController: UIViewController, UIScrollViewDelegate {
    
    //offset for animation
    var offset_HeaderStop:CGFloat!
    var offset_CoverStopScale:CGFloat!
    var offset_CardProfileStop:CGFloat!
    var offset_BackdropFadeOff:CGFloat!
    
    var user = DataModel.sharedInstance.user
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setupView() {
        let cornerRadius = view.frame.size.width*0.2
        v.coverImageView.layer.cornerRadius = cornerRadius           
        v.backgroundPhotoButtonView.layer.cornerRadius = cornerRadius*0.3
        let saveButton = UIBarButtonItem(image: UIImage(named: "save"),
                                         style: UIBarButtonItemStyle.plain ,
                                         target: self, action: #selector(self.saveProfile))
        saveButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
    
    func saveProfile(){
        print("save")
    }
}
