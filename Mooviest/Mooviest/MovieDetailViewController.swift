//
//  MovieDetailViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 5/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher
import KCFloatingActionButton


class MovieDetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MovieProtocol {

    var offset_CoverStopScale:CGFloat!
    var offset_BackdropFadeOff:CGFloat!
    var offset_HeaderStop:CGFloat!
    var offset_CardProfileStop:CGFloat!
    let offset_B_LabelHeader:CGFloat = 30
    let distance_W_LabelHeader:CGFloat = 5
    
    var movie:Movie!
    var movieListInfo:MovieListInfo!
    var ratings = [Rating]()
    var participations = [Participation]()
    var heightView:CGFloat!
    
    var v: MovieDetailView!
    var heightNav:CGFloat!
    let participationCellIdentifier = "participationCollectionViewCell"
    let ratingCellIdentifier = "ratingCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = self.navigationController?.navigationBar.frame.height
        v = MovieDetailView(heightNavBar: height!)
        DataModel.sharedInstance.getMovie(idmovie: movieListInfo.id, idMovieLang: movieListInfo.idMovieLang) {
            (data) in
            self.movie = try! Movie(json: data)
            self.loadDataView()
        }
        setupView()
        view.addSubview(v)
        setupConstraints()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //here extract predominant color
        heightView = view.frame.size.height
        changeTabs(index: 0)
        v.barSegmentedControl.selectedSegmentIndex = 0
        calculateOffset()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            if let vc = navigationController?.viewControllers[0] as? SwipeTabViewController {
                //controlar error
                vc.movies[0].idCollection = movie.idCollection
                vc.movies[0].typeMovie = movie.typeMovie
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        v.adjustFontSizeToFitHeight()
    }
    
    func loadDataView() {
        v.coverImageView.kf.setImage(with: URL(string:  movieListInfo!.image),placeholder: UIImage(named:  "noimage"))        
        //add default backdrop
        v.headerBackdropImageView.kf.setImage(with: URL(string: movie!.backdrop))
        v.headerBackdropImageView.contentMode = UIViewContentMode.scaleAspectFill
        v.infoView.synopsisTextView.text = movie?.synopsis
        v.infoView.producerTextView.text = movie?.producers.replacingOccurrences(of: " |", with: ",")
        v.infoView.genreTextView.text = movie?.genres.joined(separator: ", ")
//        v.infoView.countryTextView.text = movie.country
        
        v.captionMovieView.ratingView.ratingLabel.text = "\(movie.average)"
        v.captionMovieView.releasedLabel.text = "\(movie.released)"
        v.captionMovieView.runtimeLabel.text = "\(movie.runtime) min"
        
        ratings = movie.ratings
        participations = movie.participations
        v.infoView.ratingCollectionView.reloadData()
        v.castCollectionView.reloadData()
        
        switch movie.typeMovie {
        case TypeMovie.black.rawValue:
            v.blackItem.itemBackgroundColor = blacklist_color
            self.updateFloatButton(nameImage: "clear", backgroundColor: blacklist_color, tintColor: .white)
        case TypeMovie.favourite.rawValue:
            v.favouriteItem.itemBackgroundColor = favourite_color
            self.updateFloatButton(nameImage: "star", backgroundColor: favourite_color, tintColor: .white)
        case TypeMovie.seen.rawValue:
            v.seenItem.itemBackgroundColor = seen_color
            self.updateFloatButton(nameImage: "eye", backgroundColor: seen_color, tintColor: .white)
        case TypeMovie.watchlist.rawValue:
            v.wacthItem.itemBackgroundColor = watchlist_color
            self.updateFloatButton(nameImage: "bookmark", backgroundColor: watchlist_color, tintColor: .white)
        default:
            break
        }
        
    }
    
    func setupView() {
        v.setDelegate(ViewController: self)
        
        v.castCollectionView.dataSource = self
        v.castCollectionView.register(ParticipationCollectionViewCell.self, forCellWithReuseIdentifier: participationCellIdentifier)
        v.castCollectionView.isScrollEnabled = false 
        v.infoView.ratingCollectionView.dataSource = self
        v.infoView.ratingCollectionView.register(RatingCollectionViewCell.self, forCellWithReuseIdentifier: ratingCellIdentifier)
        
        v.barSegmentedControl.addTarget(self, action: #selector(self.changeSelected(sender:)), for: .valueChanged)
        v.captionMovieView.titleLabel.text = movieListInfo.title
        self.navigationItem.title = movieListInfo.title
        v.captionMovieView.typeLabel.text = "Película"
        
        v.coverImageView.kf.setImage(with: URL(string:  movieListInfo!.image),placeholder: UIImage(named:  "noimage"))
        v.coverImageView.contentMode = UIViewContentMode.scaleToFill
        v.coverImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        v.coverImageView.layer.borderWidth = 1.8
        v.coverImageView.layer.cornerRadius = 5
        v.coverImageView.layer.masksToBounds = true
        
        v.blackItem.handler = { item in
            self.selectBlackList(item: item)
        }
        v.seenItem.handler = { item in
            self.selectSeenList(item: item)
        }
        v.favouriteItem.handler = { item in
            self.selectFavouriteList(item: item)
        }
        v.wacthItem.handler = { item in
            self.selectWatchList(item: item)
        }
    }
    
    
    func calculateOffset() {
        offset_HeaderStop = v.headerView.frame.size.height-(self.navigationController?.navigationBar.frame.size.height)!-v.height
        offset_CoverStopScale = offset_HeaderStop
        offset_CardProfileStop = offset_HeaderStop+v.profileCardView.frame.height
        offset_BackdropFadeOff = offset_CoverStopScale/1.6
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(-offset_CardProfileStop+10, for: .default)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        v.bodyScrollView.addSubview(v.seeView)
        v.bodyScrollView.addSubview(v.castCollectionView)
        v.bodyScrollView.addSubview(v.infoView)
        
        v.bodyScrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(300, for: .default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateTypeMovie(typemovie: TypeMovie,completion: @escaping (Bool) -> Void) {
        if movie != nil {
            if movie.typeMovie == "" {//insert Collection
                DataModel.sharedInstance.insertMovieCollection(idMovie: movie.id, typeMovie: typemovie.hashValue+1){
                    (res) in
                    if let id = res["id"] as? Int {
                        self.movie.idCollection = id
                        if let typeMovie = res["typeMovie"] as? String {
                            self.movie.typeMovie = typeMovie
                            completion(true)
                        }
                    }
                }
            } else if typemovie.rawValue != movie.typeMovie {
                DataModel.sharedInstance.updateMovieCollection(idCollection: movie.idCollection,typeMovie: typemovie.hashValue+1){
                    (res) in
                    print(res)
                    if let id = res["id"] as? Int {
                        self.movie.idCollection = id
                        if let typeMovie = res["typeMovie"] as? String {
                            self.movie.typeMovie = typeMovie
                            completion(true)
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    
    func updateFloatButton(nameImage: String, backgroundColor: UIColor, tintColor:UIColor) {
        self.v.fab.buttonImage = UIImage(named: nameImage)?.withRenderingMode(.alwaysTemplate)
        self.v.fab.buttonColor = backgroundColor
        self.v.fab.plusColor = tintColor
    }
    
    func selectBlackList(item: KCFloatingActionButtonItem) {
        updateTypeMovie(typemovie: TypeMovie.black) {
            (ok) in
            if ok {
                self.v.seenItem.itemBackgroundColor = .lightGray
                self.v.wacthItem.itemBackgroundColor = .lightGray
                self.v.favouriteItem.itemBackgroundColor = .lightGray
                item.itemBackgroundColor = blacklist_color
                self.updateFloatButton(nameImage: "clear", backgroundColor: item.itemBackgroundColor!, tintColor: .white)
            }
        }
    }

    func selectSeenList(item: KCFloatingActionButtonItem) {
        updateTypeMovie(typemovie: TypeMovie.seen) {
            (ok) in
            if ok {
                self.v.blackItem.itemBackgroundColor = .lightGray
                self.v.wacthItem.itemBackgroundColor = .lightGray
                self.v.favouriteItem.itemBackgroundColor = .lightGray
                item.itemBackgroundColor = seen_color
                self.updateFloatButton(nameImage: "eye", backgroundColor: item.itemBackgroundColor!, tintColor: .white)
            }
        }
    }

    func selectFavouriteList(item: KCFloatingActionButtonItem) {
        updateTypeMovie(typemovie: TypeMovie.favourite) {
            (ok) in
            if ok {
                self.v.blackItem.itemBackgroundColor = .lightGray
                self.v.seenItem.itemBackgroundColor = .lightGray
                self.v.wacthItem.itemBackgroundColor = .lightGray
                item.itemBackgroundColor = favourite_color
                self.updateFloatButton(nameImage: "star", backgroundColor: item.itemBackgroundColor!, tintColor: .white)
            }
        }
    }

    func selectWatchList(item: KCFloatingActionButtonItem) {
        v.blackItem.itemBackgroundColor = .lightGray
        v.seenItem.itemBackgroundColor = .lightGray
        v.favouriteItem.itemBackgroundColor = .lightGray
        
        updateTypeMovie(typemovie: TypeMovie.watchlist) {
            (ok) in
            if ok {
                item.itemBackgroundColor = watchlist_color
                self.updateFloatButton(nameImage: "bookmark", backgroundColor: item.itemBackgroundColor!, tintColor: .white)
            }
        }
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
            var noScrollTransform = CATransform3DIdentity

            if offset < 0 {
                let headerScaleFactor:CGFloat = -(offset) / v.headerView.bounds.height
                let headerSizevariation = ((v.headerView.bounds.height * (1.0 + headerScaleFactor)) - v.headerView.bounds.height)/2.0
                headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation*0.5, 0)
                cardTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
                headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
                noScrollTransform = cardTransform
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
                
                //Animations
                headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
                cardTransform = CATransform3DTranslate(cardTransform, 0, max(-offset_CardProfileStop, -offset), 0)
                noScrollTransform = CATransform3DTranslate(noScrollTransform, 0, -offset, 0)
                
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
                        v.fab.layer.zPosition = 3
                    }
                }
            }
            v.headerView.layer.transform = headerTransform
            v.coverImageView.layer.transform = avatarTransform
            v.profileCardView.layer.transform  = cardTransform
            v.barSegmentedView.layer.transform = cardTransform
            v.castCollectionView.layer.transform  = cardTransform
            v.infoView.layer.transform  = noScrollTransform
            v.seeView.layer.transform  = noScrollTransform
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
            calculateContentSize(height: v.seeView.frame.height)
        default:
            v.castCollectionView.isHidden = true
            v.seeView.isHidden = true
            v.infoView.isHidden = false
            print("default")
            calculateContentSize(height: v.infoView.calculateHeight())
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
        if collectionView == v.infoView.ratingCollectionView {
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: ratingCellIdentifier, for: indexPath as IndexPath) as! RatingCollectionViewCell
            cell = loadRatingToView(RatingCollectionViewCell: customCell, Rating: ratings[indexPath.item])
        } else {
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: participationCellIdentifier, for: indexPath as IndexPath) as! ParticipationCollectionViewCell
            cell = loadParticipationToView(ParticipationCollectionViewCell: customCell, participation: participations[indexPath.item])
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == v.infoView.ratingCollectionView {
            count = ratings.count
        } else {
            count = participations.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size:CGSize!
        if collectionView == v.infoView.ratingCollectionView {
            let height = collectionView.frame.height
            size = CGSize(width: height*0.7, height: height)
        } else {
            let width = (collectionView.frame.width/3)-1
            size = CGSize(width: width, height: width*1.30)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == v.castCollectionView {
            print(participations[indexPath.item].name)
        }
    }
}
