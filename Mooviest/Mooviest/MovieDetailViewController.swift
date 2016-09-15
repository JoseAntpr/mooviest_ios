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
var offset_HeaderStop:CGFloat! // = 80 // At this offset the Header stops its transformations
var segmentViewOffset:CGFloat!
let offset_B_LabelHeader:CGFloat = 30 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 5 // The distance between the bottom of the Header and the top of the White Label

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {//, UICollectionViewDelegate, UICollectionViewDataSource {
    var movie:Movie?
    var heightView:CGFloat!
    var v: MovieDetailView!
    var heightNav:CGFloat!
    let customCellIdentifier = "participationCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        v = MovieDetailView()
        v.bodyScrollView.contentSize.height = 2500
        v.bodyScrollView.delegate = self
       // v.castView.delegate = self
      //  v.castView.registerClass(ParticipationCollectionViewCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        setupView()
        view.addSubview(v)
        setupConstraints()
        
        heightView = view.frame.size.height
        switch heightView {
        case 736:
            offset_CoverStopScale = CGFloat(138)
            offset_HeaderStop = offset_CoverStopScale*1.12
            segmentViewOffset = 261
            print("IPhone 6 plus")
        case 667:
            offset_CoverStopScale = CGFloat(120)
            offset_HeaderStop = offset_CoverStopScale*1.12
            segmentViewOffset = 238
            print("IPhone 6")
        case 568:
            offset_CoverStopScale = CGFloat(90)
            offset_HeaderStop = offset_CoverStopScale*1.2
            segmentViewOffset = 209
            print("IPhone 5")
        default:
            offset_CoverStopScale = CGFloat(90)
            offset_HeaderStop = offset_CoverStopScale*1.2
            segmentViewOffset = 209
            
        }
        offset_BackdropFadeOff = offset_CoverStopScale/1.6
        
    }
    
    func setupView() {
        
        v.coverImageView.kf_setImage(with: URL(string:  movie!.image))
        v.coverImageView.contentMode = UIViewContentMode.scaleToFill
        v.coverImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        v.coverImageView.layer.borderWidth = 1.8
        v.coverImageView.layer.cornerRadius = 5
        v.coverImageView.layer.masksToBounds = true
        v.headerBackdropImageView.kf_setImage(with: URL(string: "https://img.tviso.com/ES/backdrop/w600\(movie!.backdrop)"))
        v.headerBackdropImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        v.barSegmentedControl.addTarget(self, action: #selector(self.changeSelected(sender:)), for: .valueChanged)
        
        v.infoView.synopsisTextView.text = movie?.synopsis
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let colors = v.headerBackdropImageView.image!.getColors()
//        
//        //        backgroundView.backgroundColor = colors.backgroundColor
//        //        mainLabel.textColor = colors.primaryColor
//        //        secondaryLabel.textColor = colors.secondaryColor
//        //        detailLabel.textColor = colors.detailColor headerBackdropImageView.image?.getColors()
//        //        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
//        //        let blurView = UIVisualEffectView(effect: blurEffect)
//        //        blurView.frame =  v.headerBackdropImageView.frame
//        //        v.headerBackdropImageView.addSubview(blurView)
//        
//        v.headerLabel.textColor = colors.backgroundColor
//        v.headerView.backgroundColor = colors.primaryColor
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
   
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        var segmentTransform = CATransform3DIdentity
        print(offset)
        // PULL DOWN -----------------
        
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / v.headerView.bounds.height
            let headerSizevariation = ((v.headerView.bounds.height * (1.0 + headerScaleFactor)) - v.headerView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            //v.headerView.layer.transform = headerTransform
        } else {    // SCROLL UP/DOWN ------------
            
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
            //            print("cover : \(v.coverImageView.frame.origin)")
            //            print("cover size : \(v.coverImageView.frame.size)")
            //            print("cover top: \(v.coverImageView.frame.origin.y-v.coverImageView.frame.size.height)")
            //            print("header : \(v.headerView.frame.origin)")
            //            print("header size: \(v.headerView.frame.size)")
            //            print("header bottom: \(v.headerView.frame.origin.y+v.headerView.frame.size.height)")
            let avatarScaleFactor = (min(offset_CoverStopScale, offset)) / v.coverImageView.bounds.height  // Slow down the animation
            let avatarSizeVariation = ((v.coverImageView.bounds.height * (1.0 + avatarScaleFactor)) - v.coverImageView.bounds.height)
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, 0.5*avatarSizeVariation, 0)
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
            
            // Segment control
            
            // Scroll the segment view until its offset reaches the same offset at which the header stopped shrinking
            //segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset, -offset_HeaderStop*1.60), 0)
            if segmentViewOffset < offset {
                print("transfor: \(offset)")
                segmentTransform = CATransform3DTranslate(segmentTransform, 0,offset-segmentViewOffset, 0)
                //                v.barSegmentedView.layer.transform = segmentTransform
                
            }
        }
        // Apply Transformations
        v.barSegmentedView.layer.transform = segmentTransform
        v.headerView.layer.transform = headerTransform
        v.coverImageView.layer.transform = avatarTransform
        
    }
    
    func changeSelected(sender: UISegmentedControl) {
        print("Change selected")
        switch sender.selectedSegmentIndex {
        case 1:
            v.castView.isHidden = false
            v.seeView.isHidden = true
            v.infoView.isHidden = true
            print("1")
        case 2:
            v.castView.isHidden = true
            v.seeView.isHidden = false
            v.infoView.isHidden = true
            print("2")
        default:
            v.castView.isHidden = true
            v.seeView.isHidden = true
            v.infoView.isHidden = false
            print("default")
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath as IndexPath)
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
