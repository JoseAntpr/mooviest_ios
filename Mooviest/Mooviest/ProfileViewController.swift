//
//  ProfileViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 9/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher



class ProfileViewController: UIViewController, UIScrollViewDelegate, TabBarProtocol {
    
    //offset for animation
    var offset_HeaderStop:CGFloat!
    var offset_CoverStopScale:CGFloat!
    var offset_CardProfileStop:CGFloat!
    var offset_BackdropFadeOff:CGFloat!
    let distance_W_LabelHeader:CGFloat = 5
    
    var user:User?
    var heightView:CGFloat!
    var v: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()
        v = ProfileView()
        v.bodyScrollView.delegate = self
        setupView()
        view.addSubview(v)
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        //here extract predominant color
        v.bodyScrollView.contentSize.height = view.frame.size.height*1.15+v.barSegmentedView.center.y-v.barSegmentedView.frame.height*1.8
        calculateOffset()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetTabBarAndNavigationController(viewController: self)
        v.bodyScrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(300, for: .default)
        user = DataModel.sharedInstance.user
        loadDataView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func loadDataView() {
        if let avatar = user?.avatar {
            v.coverImageView.kf.setImage(with: URL(string:  "\(DataModel.sharedInstance.path)\(avatar)"),placeholder: UIImage(named: "contact"))
        }
        navigationItem.title = "Profile"
        if user != nil {
            v.usernameLabel.text = "@\(user!.username)"
            v.firstnameLabel.text = "\(user!.firstname)"
            v.lastnameLabel.text = "\(user!.lastname)"
            navigationItem.title = "@\(user!.username)"
        }
    }
    
    //This method is called when the autolayout engine has finished to calculate your views' frames
    override func viewDidLayoutSubviews() {
        v.coverImageView.layer.cornerRadius = v.coverImageView.bounds.size.width*0.5
        v.coverImageView.clipsToBounds = true
    }
    
    func setupView() {
        v.barSegmentedControl.addTarget(self, action: #selector(self.changeSelected(sender:)), for: .valueChanged)
        let editButton = UIBarButtonItem(image: UIImage(named: "edit"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.editProfile))
        editButton.tintColor = mooviest_red
        let replayButton = UIBarButtonItem(image: UIImage(named: "logout"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.logout))
        replayButton.tintColor = mooviest_red
        navigationItem.leftBarButtonItem = replayButton
    
        navigationItem.rightBarButtonItem = editButton
        DataModel.sharedInstance.getUser() {
            (successful, title, msg) in
            if successful {
                self.user = DataModel.sharedInstance.user
                self.loadDataView()
            } else {
                Message.msgPopupDelay(title:  title, message: msg!, delay: 0, ctrl: self) {}
            }
        }
    }
    
    func logout() {
        DataModel.sharedInstance.resetDataUser()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = LoginViewController()
    }
    
    func calculateOffset() {
        offset_HeaderStop = v.headerView.frame.size.height-(self.navigationController?.navigationBar.frame.size.height)!-v.height
        offset_CoverStopScale = offset_HeaderStop
        offset_CardProfileStop = offset_HeaderStop+v.profileCardView.frame.height+10
        offset_BackdropFadeOff = offset_CoverStopScale/1.6
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(-offset_CardProfileStop+10, for: .default)
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == v.bodyScrollView {
            let offset = scrollView.contentOffset.y
            var avatarTransform = CATransform3DIdentity
            var headerTransform = CATransform3DIdentity
            var cardTransform = CATransform3DIdentity
            
            if offset < 0 {
                let headerScaleFactor:CGFloat = -(offset) / v.headerView.bounds.height
                let headerSizevariation = ((v.headerView.bounds.height * (1.0 + headerScaleFactor)) - v.headerView.bounds.height)/2.0
                headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation*0.5, 0)
                cardTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
                headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
                
                if v.coverImageView.layer.zPosition < v.headerView.layer.zPosition{
                    v.headerView.layer.zPosition = 0
                }
                
            } else {
                //Alpha
                v.headerBackdropImageView.alpha = max (0, (1-( offset-offset_BackdropFadeOff*3)/distance_W_LabelHeader)/10)
                let move  = max(offset_CardProfileStop-offset,0)
                self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(move, for: .default)
                
                //Animations
                headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
                cardTransform = CATransform3DTranslate(cardTransform, 0, max(-offset_CardProfileStop, -offset), 0)
                
                let avatarScaleFactor = (min(offset_CoverStopScale, offset)) / v.coverImageView.bounds.height
                let avatarSizeVariation = ((v.coverImageView.bounds.height * (1.0 + avatarScaleFactor)) - v.coverImageView.bounds.height)
                avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation*0.5, 0)
                avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
                
                if offset <= offset_CoverStopScale! {
                    if v.coverImageView.layer.zPosition < v.headerView.layer.zPosition{
                        v.headerView.layer.zPosition = 0
                    }
                }
                else {
                    if v.coverImageView.layer.zPosition >= v.headerView.layer.zPosition{
                        v.headerView.layer.zPosition = 1
                        v.barSegmentedView.layer.zPosition = 2
                        v.backgroundStatusView.layer.zPosition = 3
                    }
                }
            }
            v.headerView.layer.transform = headerTransform
            v.coverImageView.layer.transform = avatarTransform
            v.profileCardView.layer.transform  = cardTransform
            v.barSegmentedView.layer.transform = cardTransform
            //finalmente cada tab tendrá su propio transform en funcion de su height
            v.tabsView.layer.transform  = cardTransform
        }
    }
    
    func changeSelected(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            v.followingView.isHidden = false
            v.followersView.isHidden = true
        default:
            v.followingView.isHidden = true
            v.followersView.isHidden = false
        }
    }
    
    func editProfile(){
        
        navigationItem.title = NSLocalizedString("titleTabProfile", comment: "Title of TabProfile")
        let nViewController = EditProfileViewController()
        nViewController.user = DataModel.sharedInstance.user
        
        navigationController?.pushViewController(nViewController, animated: true)
    }
}
