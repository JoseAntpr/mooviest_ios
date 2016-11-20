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
import Chameleon

class MovieDetailViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate,  UICollectionViewDataSource,
                    UICollectionViewDelegateFlowLayout, MovieProtocol,  TabBarProtocol {
    var delegate: DetailMovieDelegate?
    var offset_CoverStopScale:CGFloat!
    var offset_BackdropFadeOff:CGFloat!
    var offset_HeaderStop:CGFloat!
    var offset_CardProfileStop:CGFloat!
    let offset_B_LabelHeader:CGFloat = 30
    let distance_W_LabelHeader:CGFloat = 5
    var backgroundColor = mooviest_red
    var tintColor:UIColor!
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
            successful, title, message, res in
            if successful {
                do {
                    self.movie = try Movie(json: res)
                    self.loadDataView()
                } catch {
                    let title = NSLocalizedString("getMovieTitle", comment: "Title of getMovie")
                    let msg = NSLocalizedString("getMovieMsg", comment: "Message of getMovie")
                    Message.msgPopupDelay(title: title, message: msg, delay: 0, ctrl: self) {}
                }
            } else {
                Message.msgPopupDelay(title: title, message: message!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
            }
        }
        setupView()
        view.addSubview(v)
        setupConstraints()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLayoutSubviews() {
        v.adjustFontSizeToFitHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        v.bodyScrollView.addSubview(v.seeView)
        v.bodyScrollView.addSubview(v.castCollectionView)
        v.bodyScrollView.addSubview(v.infoView)
        if tintColor != nil {
            self.setColors(viewController: self, backgroundColor: backgroundColor, tintColor: tintColor)
        }
//        v.bodyScrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(300, for: .default)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        heightView = view.frame.size.height
        changeTabs(index: v.barSegmentedControl.selectedSegmentIndex)
        calculateOffset()
    }
    
    func updateColor(image:UIImage?) {
        if image != nil {
            backgroundColor = AverageColorFromImage(image!)
            tintColor = ContrastColorOf(backgroundColor,returnFlat: true)
            v.setColors(backgroundColor: backgroundColor, tintColor: tintColor)
            self.setColors(viewController: self, backgroundColor: backgroundColor, tintColor: tintColor)
            if movieListInfo.idCollection < 0 {
                self.updateFloatPlustButton(image: "add", backgroundColor: backgroundColor, tintColor: tintColor)
            }
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
        
        v.coverImageView.kf.setImage(with: URL(string:  movieListInfo!.image))       
        v.headerBackdropImageView.kf.setImage(with: URL(string: movieListInfo!.backdrop), completionHandler: {
            (image, error, cacheType, imageUrl) in
            if image != nil {
                self.updateColor(image: image)
            } else {
                self.v.headerBackdropImageView.image = UIImage(named: "backdrop")?.withRenderingMode(.alwaysTemplate)
                self.v.headerBackdropImageView.tintColor = mooviest_red
                self.v.headerBackdropImageView.contentMode = UIViewContentMode.scaleAspectFill
                if let img = self.v.coverImageView.image {
                    self.updateColor(image: img)
                }
            }
        })
        v.headerBackdropImageView.contentMode = UIViewContentMode.scaleAspectFill
        
        switch movieListInfo.typeMovie {
        case TypeMovie.black.rawValue:
            self.v.blackItem.buttonColor = TypeMovie.black.color
            updateFloatPlustButton(image: TypeMovie.black.image, backgroundColor: TypeMovie.black.color, tintColor: .white)
        case TypeMovie.favourite.rawValue:
            self.v.favouriteItem.buttonColor = TypeMovie.favourite.color
            updateFloatPlustButton(image: TypeMovie.favourite.image, backgroundColor: TypeMovie.favourite.color, tintColor: .white)
        case TypeMovie.seen.rawValue:
            self.v.seenItem.buttonColor = TypeMovie.seen.color
            updateFloatPlustButton(image: TypeMovie.seen.image, backgroundColor: TypeMovie.seen.color, tintColor: .white)
        case TypeMovie.watchlist.rawValue:
            self.v.watchItem.buttonColor = TypeMovie.watchlist.color
            updateFloatPlustButton(image: TypeMovie.watchlist.image, backgroundColor: TypeMovie.watchlist.color, tintColor: .white)
        default:
            self.v.blackItem.buttonColor = blacklist_color
            self.v.seenItem.buttonColor = seen_color
            self.v.watchItem.buttonColor = watchlist_color
            self.v.favouriteItem.buttonColor = favourite_color
            break
        }
        
        v.blackItem.handler = { item in
            self.selectList(item: item, typemovie: TypeMovie.black)
        }
        v.seenItem.handler = { item in
            self.selectList(item: item, typemovie: TypeMovie.seen)
        }
        v.favouriteItem.handler = { item in
            self.selectList(item: item, typemovie: TypeMovie.favourite)
        }
        v.watchItem.handler = { item in
            self.selectList(item: item, typemovie: TypeMovie.watchlist)
        }
        
        let rating = Rating(name: "mooviest", rating: Int(movieListInfo.average), count: 0, dateUpdate: "")
        ratings.append(rating)
    }

    func loadDataView() {
        
        //add default backdrop
        v.headerBackdropImageView.contentMode = UIViewContentMode.scaleAspectFill
        v.infoView.synopsisTextView.text = movie?.synopsis
        v.infoView.producerTextView.text = movie?.producers.replacingOccurrences(of: " |", with: ",")
        v.infoView.genreTextView.text = movie?.genres.joined(separator: ", ")
        v.captionMovieView.releasedLabel.text = "\(movie.released)"
        v.captionMovieView.runtimeLabel.text = "\(movie.runtime) min"
        
        ratings.append(contentsOf: movie.ratings)
        participations = movie.participations
        v.infoView.ratingCollectionView.reloadData()
        v.castCollectionView.reloadData()
    }
    
    func calculateOffset() {
        offset_HeaderStop = v.headerView.frame.size.height-(self.navigationController?.navigationBar.frame.size.height)!-v.height
        offset_CoverStopScale = offset_HeaderStop
        offset_CardProfileStop = offset_HeaderStop+v.profileCardView.frame.height
        offset_BackdropFadeOff = offset_CoverStopScale/1.6
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(-offset_CardProfileStop+10, for: .default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateMovie(res: [String:Any]) {
        if let id = res["id"] as? Int {
            movie.idCollection = id
            if let typeMovie = res["typeMovie"] as? String {
                movie.typeMovie = typeMovie
                delegate?.updateClasificationMovie(movie)
            }
        }
    }
    
    func updateTypeMovie(typemovie: TypeMovieModel,completion: @escaping (Bool,String,String?) -> Void) {
        let queue = DispatchQueue(label: "mooviest.updateTypeMovie")
        queue.async {
            if self.movie != nil {
                if self.movie.typeMovie == "" {
                    DataModel.sharedInstance.insertMovieCollection(idMovie: self.movie.id, typeMovie: typemovie.hashValue){
                        (successful, title, msg, res) in
                        completion(successful, title, msg)
                        self.updateMovie(res: res)
                    }
                } else if typemovie.rawValue != self.movie.typeMovie {
                    DataModel.sharedInstance.updateMovieCollection(idCollection: self.movie.idCollection,typeMovie: typemovie.hashValue){
                        (successful, title, msg, res) in
                        completion(successful, title, msg)
                        self.updateMovie(res: res)
                    }
                } else {
                    completion(true, "", "")
                }
            } else {
                let title = NSLocalizedString("getMovieTitle", comment: "Title of getMovie")
                let msg = NSLocalizedString("getMovieMsg", comment: "Message of getMovie")
                completion(false, title, msg)
            }
        }
    }
    
    func updateFloatPlustButton(image: String, backgroundColor: UIColor, tintColor:UIColor) {
        self.v.fab.buttonImage = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        self.v.fab.buttonColor = backgroundColor.withAlphaComponent(0.7)
        self.v.fab.plusColor = tintColor
    }
    
    func updateFloatButtons(item: KCFloatingActionButtonItem,  typemovie: TypeMovieModel) {
        let backgroundColor = typemovie.color
        self.v.blackItem.itemBackgroundColor = .lightGray
        self.v.seenItem.itemBackgroundColor = .lightGray
        self.v.watchItem.itemBackgroundColor = .lightGray
        self.v.favouriteItem.itemBackgroundColor = .lightGray
        item.itemBackgroundColor = backgroundColor
        updateFloatPlustButton(image: typemovie.image, backgroundColor: backgroundColor, tintColor: .white)
    }
    
    func selectList(item: KCFloatingActionButtonItem, typemovie: TypeMovieModel) {
        self.updateFloatButtons(item: item, typemovie: typemovie)
        updateTypeMovie(typemovie: typemovie) {
            (successful, title, msg) in
            if !successful {
                Message.msgPopupDelay(title: title, message: msg!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
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
                if v.coverView.layer.zPosition < v.headerView.layer.zPosition{
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
                
                let avatarScaleFactor = (min(offset_CoverStopScale, offset)) / v.coverView.bounds.height
                let avatarSizeVariation = ((v.coverView.bounds.height * (1.0 + avatarScaleFactor)) - v.coverView.bounds.height)
                avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation*0.5, 0)
                avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
                
                if offset <= offset_CoverStopScale! {
                    if v.coverView.layer.zPosition < v.headerView.layer.zPosition{
                        v.headerView.layer.zPosition = 0
                    }
                }
                else {
                    if v.coverView.layer.zPosition >= v.headerView.layer.zPosition{
                        v.headerView.layer.zPosition = 1
                        v.barSegmentedView.layer.zPosition = 2
                        v.backgroundStatusView.layer.zPosition = 3
                        v.fab.layer.zPosition = 3
                    }
                }
            }
            v.headerView.layer.transform = headerTransform
            v.coverView.layer.transform = avatarTransform
            v.profileCardView.layer.transform  = cardTransform
            v.barSegmentedView.layer.transform = cardTransform
            v.castCollectionView.layer.transform  = cardTransform
            v.infoView.layer.transform  = noScrollTransform
            v.seeView.layer.transform  = noScrollTransform
        }
    }
    
    func calculateContentSize(height h: CGFloat) {
        v.bodyScrollView.contentSize.height = view.frame.size.height-v.barSegmentedView.center.y+v.barSegmentedView.frame.size.height*2+h+7.5
    }
        
    func changeTabs(index: Int){
        switch index {
        case 1:
            v.castCollectionView.isHidden = false
            v.seeView.isHidden = true
            v.infoView.isHidden = true
            calculateContentSize(height: v.castCollectionView.contentSize.height)
        case 2:
            v.castCollectionView.isHidden = true
            v.seeView.isHidden = false
            v.infoView.isHidden = true
            calculateContentSize(height: v.seeView.frame.height)
        default:
            v.castCollectionView.isHidden = true
            v.seeView.isHidden = true
            v.infoView.isHidden = false
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
        if collectionView == v.castCollectionView && participations.count > indexPath.item {
            let nViewController = ListMovieCastController()
            nViewController.nextUrl = ""
            nViewController.participation = participations[indexPath.item]
            navigationController?.pushViewController(nViewController, animated: true)
        }
    }
}
