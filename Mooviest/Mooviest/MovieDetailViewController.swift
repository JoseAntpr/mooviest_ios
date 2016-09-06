//
//  MovieDetailViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 5/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
var offset_CoverStopScale:CGFloat!
var offset_BackdropFadeOff:CGFloat!
let offset_HeaderStop:CGFloat = 40 // At this offset the Header stops its transformations

let offset_B_LabelHeader:CGFloat = 30 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 5 // The distance between the bottom of the Header and the top of the White Label

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var heightView:CGFloat!
    var v: MovieDetailView!
    var heightNav:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        v = MovieDetailView()
        v.bodyScrollView.contentSize.height = 2500
        v.bodyScrollView.delegate = self
        view.addSubview(v)
        setupConstraints()
        heightView = view.frame.size.height
        switch heightView {
        case 736:
            offset_CoverStopScale = CGFloat(60)
            print("IPhone 6 plus")
        case 667:
             offset_CoverStopScale = CGFloat(47)
            print("IPhone 6")
        case 568:
            offset_CoverStopScale = CGFloat(34)
            print("IPhone 5")
        default:
            offset_CoverStopScale = CGFloat(34)
            
        }
        print(offset_CoverStopScale)
        offset_BackdropFadeOff = offset_CoverStopScale/1.3
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraintEqualToAnchor(view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraintEqualToAnchor(view.rightAnchor))
        view.addConstraint(v.topAnchor.constraintEqualToAnchor(view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor))
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        print(offset)
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / v.headerView.bounds.height
            let headerSizevariation = ((v.headerView.bounds.height * (1.0 + headerScaleFactor)) - v.headerView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            //v.headerView.layer.transform = headerTransform
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            //  ------------ Label
//            if offset >= 117 {
//                let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
//                v.headerLabel.layer.transform = labelTransform
//            }
            
            //  ------------ Blur
            
           v.headerBackdropImageView.alpha = max (0, (1-( offset-offset_BackdropFadeOff*3)/distance_W_LabelHeader)/10)
           
            // Avatar -----------
            print("cover : \(v.coverImageView.frame.origin)")
            print("cover size : \(v.coverImageView.frame.size)")
            print("cover top: \(v.coverImageView.frame.origin.y-v.coverImageView.frame.size.height)")
            print("header : \(v.headerView.frame.origin)")
            print("header size: \(v.headerView.frame.size)")
            print("header bottom: \(v.headerView.frame.origin.y+v.headerView.frame.size.height)")
            let avatarScaleFactor = (min(offset_CoverStopScale, offset)) / v.coverImageView.bounds.height / 1.3  // Slow down the animation
            let avatarSizeVariation = ((v.coverImageView.bounds.height * (1.0 + avatarScaleFactor)) - v.coverImageView.bounds.height)
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, 2*avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_CoverStopScale {
                if v.coverImageView.layer.zPosition < v.headerView.layer.zPosition{
                    v.headerView.layer.zPosition = 0
                }
            }
            else {
                if v.coverImageView.layer.zPosition >= v.headerView.layer.zPosition{
                    v.headerView.layer.zPosition = 1
                    v.backgroundStatusView.layer.zPosition = 2
                }
            }
            
        }
        
        // Apply Transformations
        v.headerView.layer.transform = headerTransform
        v.coverImageView.layer.transform = avatarTransform
       
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
