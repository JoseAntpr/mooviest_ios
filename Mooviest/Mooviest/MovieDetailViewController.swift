//
//  MovieDetailViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 5/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher



class MovieDetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var offset_CoverStopScale:CGFloat!
    var offset_BackdropFadeOff:CGFloat!
    var offset_HeaderStop:CGFloat!
    var offset_CardProfileStop:CGFloat!
    let offset_B_LabelHeader:CGFloat = 30
    let distance_W_LabelHeader:CGFloat = 5
    
    var movie:Movie!
    var heightView:CGFloat!
    
    var v: MovieDetailView!
    var heightNav:CGFloat!
    let participationCellIdentifier = "participationCollectionViewCell"
    let ratingCellIdentifier = "ratingCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = self.navigationController?.navigationBar.frame.height
        v = MovieDetailView(heightNavBar: height!)
        
        v.setDelegate(ViewController: self)
        
        v.castCollectionView.dataSource = self
        v.castCollectionView.register(ParticipationCollectionViewCell.self, forCellWithReuseIdentifier: participationCellIdentifier)
        
        v.infoView.ratingCollectionView.dataSource = self
        v.infoView.ratingCollectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: ratingCellIdentifier)
        
        setupView()
        view.addSubview(v)
        setupConstraints()
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
        v.titleLabel.text = movie.title
        self.navigationItem.title = movie.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //here extract predominant color
        heightView = view.frame.size.height
        v.seeScrollView.contentSize.height = v.seeView.frame.size.height*2
        v.infoScrollView.contentSize.height = v.seeView.frame.size.height
        changeTabs(index: 0)
        calculateOffset()        
    }
    override func viewDidDisappear(_ animated: Bool) {
    }
    override func viewWillDisappear(_ animated: Bool) {
    }
    func calculateOffset() {
        offset_HeaderStop = v.headerView.frame.size.height-(self.navigationController?.navigationBar.frame.size.height)!-v.height
        offset_CoverStopScale = offset_HeaderStop
        offset_CardProfileStop = offset_HeaderStop+v.profileCardView.frame.height
        offset_BackdropFadeOff = offset_CoverStopScale/1.6
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(-offset_CardProfileStop+10, for: .default)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        v.bodyScrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(300, for: .default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                let offsetTitle  = max(offset_CardProfileStop-offset,0)
                self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(offsetTitle, for: .default)
                let offsetCaTabs  = max(offset-offset_CardProfileStop,0)
                
                v.castCollectionView.contentOffset.y = offsetCaTabs
                v.seeScrollView.contentOffset.y = offsetCaTabs
                v.infoScrollView.contentOffset.y = offsetCaTabs
                
                //Animations
                headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
                cardTransform = CATransform3DTranslate(cardTransform, 0, max(-offset_CardProfileStop, -offset), 0)
                
                let avatarScaleFactor = (min(offset_CoverStopScale, offset)) / v.coverImageView.bounds.height
                let avatarSizeVariation = ((v.coverImageView.bounds.height * (1.0 + avatarScaleFactor)) - v.coverImageView.bounds.height)
                avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation*0.5, 0)
                avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
                
                if offset <= offset_CoverStopScale {
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
    
    func calculateContentSize(height h: CGFloat) {
        v.bodyScrollView.contentSize.height = view.frame.size.height-v.barSegmentedView.center.y+v.barSegmentedView.frame.size.height*2+h+10
    }
        
    func changeTabs(index: Int){
        switch index {
        case 1:
            v.castCollectionView.isHidden = false
            v.seeView.isHidden = true
            v.infoView.isHidden = true
            print("1")
            calculateContentSize(height: v.castCollectionView.contentSize.height)
            
        case 2:
            v.castCollectionView.isHidden = true
            v.seeView.isHidden = false
            v.infoView.isHidden = true
            print("2")
            calculateContentSize(height: v.seeScrollView.contentSize.height)
        default:
            v.castCollectionView.isHidden = true
            v.seeView.isHidden = true
            v.infoView.isHidden = false
            print("default")
            calculateContentSize(height: v.infoScrollView.contentSize.height)
        }
    }
    
    func changeSelected(sender: UISegmentedControl) {
        if offset_CardProfileStop != nil && offset_CardProfileStop < v.bodyScrollView.contentOffset.y {
            v.bodyScrollView.setContentOffset(CGPoint(x:0,y:offset_CardProfileStop), animated: false)
        }
        changeTabs(index: sender.selectedSegmentIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell!
        if collectionView == v.castCollectionView {
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: participationCellIdentifier, for: indexPath as IndexPath) as! ParticipationCollectionViewCell
            customCell.backgroundColor = UIColor.red
            let url = URL(string: movie.participations[indexPath.item].image)
            customCell.faceImageView.kf_setImage(with: url,placeholder: UIImage(named:  "noimage"))
            cell = customCell
        } else {
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: ratingCellIdentifier, for: indexPath as IndexPath) as! RatingCollectionViewCell
            customCell.backgroundColor = UIColor.red
            customCell.faceImageView.image = UIImage(named:  movie.ratings[indexPath.item].name)
            cell = customCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == v.castCollectionView {
            count = movie.participations.count
        } else {
            count = movie!.ratings.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size:CGSize!
        if collectionView == v.castCollectionView {
            let width = (collectionView.frame.width/3)-1
            size = CGSize(width: width, height: width*1.30)
        } else {
            let width = (collectionView.frame.width/6)-1
            size = CGSize(width: width, height: width)
        }
        return size
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
