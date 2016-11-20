
//
//  SwipeTabViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit
import Kingfisher

class SwipeTabViewController: UIViewController, DraggableViewDelegate, MovieProtocol, TabBarProtocol, DetailMovieDelegate {
    let MAX_BUFFER_SIZE = 4
    let MIN_CARDS = 9
    var v: SwipeTabView!
    var allCards: [DraggableView]!
    var nextUrl = ""
    var loadedCards = [DraggableView]()
    var movies = [MovieListInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = self.navigationController?.navigationBar.frame.height
        v = SwipeTabView(heightNavBar: height!)
        view.addSubview(v)
        setupConstraints()
        setupView()
        initSwipe()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         updateSwipe()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.resetTabBarAndNavigationController(viewController: self)
               
    }
    
    func setupView() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.search))
        searchButton.tintColor = mooviest_red
        
        let replayButton = UIBarButtonItem(image: UIImage(named: "autorenew"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.reloadSwipe))
        replayButton.tintColor = mooviest_red
        navigationItem.leftBarButtonItem = replayButton
        navigationItem.rightBarButtonItem = searchButton
        //
        
        v.blackButton.addTarget(self, action: #selector(self.clickSwipeBottom), for: .touchUpInside)
        v.favouriteButton.addTarget(self, action: #selector(self.clickSwipeTop), for: .touchUpInside)
        v.watchButton.addTarget(self, action: #selector(self.clickSwipeLeft), for: .touchUpInside)
        v.seenButton.addTarget(self, action: #selector(self.clickSwipeRight), for: .touchUpInside)
        
    }
    
    func initSwipe() {
        DataModel.sharedInstance.getMoviesSwipe() {
            (successful, title, msg, res) in
            if successful {
                self.movies.removeAll()
                self.nextUrl = ""
                self.nextUrl.toString(string: res["next"] as Any)
                if let results = res["results"] as? [[String:Any]] {
                    for m in results {
                        let movie:MovieListInfo?
                        do {
                            movie = try MovieListInfo(json: m, isSwwipe: true)
                            self.movies.append(movie!)
                        } catch {
                            movie = nil
                        }
                    }
                }
                self.allCards = []
                self.loadedCards = []
                self.loadCards()
            } else {
                
            }
        }
    }
    
    func reloadSwipe() {
        for card in loadedCards {
            card.removeFromSuperview()
        }
        initSwipe()
        
    }
    
    func updateBadgeValue() {
        var count = 0
        let value = tabBarController?.tabBar.items?[1].badgeValue
        if value != nil && value != "" {
            count = Int(value!)!
        }
        tabBarController?.tabBar.items?[1].badgeValue   = "\(count+1)"
    }
    //
    func updateSwipe() {
        if movies.count > 0 && movies[0].typeMovie != "" {
            switch movies[0].typeMovie {
            case TypeMovie.watchlist.rawValue:
                clickSwipeLeft()
            case TypeMovie.seen.rawValue:
                clickSwipeRight()
            case TypeMovie.favourite.rawValue:
                clickSwipeTop()
            default:
                clickSwipeBottom()
            }
        }        
    }
    
    func updateClasificationMovie(_ movie: Movie) {
        if movies.count > 0 {
            if movies[0].id == movie.id {
                movies[0].idCollection = movie.idCollection
                movies[0].typeMovie = movie.typeMovie
            }
        }
    }
    
    //This method is called when the autolayout engine has finished to calculate your views' frames
    override func viewDidLayoutSubviews() {
        let widthButton = v.blackButton.bounds.size.width
        
        v.blackButton.layer.cornerRadius = 0.5 * widthButton
        v.blackButton.clipsToBounds = true
        v.watchButton.layer.cornerRadius = 0.5 * widthButton
        v.watchButton.clipsToBounds = true
        v.favouriteButton.layer.cornerRadius = 0.5 * widthButton
        v.favouriteButton.clipsToBounds = true
        v.seenButton.layer.cornerRadius = 0.5 * widthButton
        v.seenButton.clipsToBounds = true
        if loadedCards.count > 0 {
            
            loadedCards[0].overlayView.layer.cornerRadius = 0.5 * loadedCards[0].overlayView.bounds.size.height
            loadedCards[0].overlayView.clipsToBounds = true
        }
    }
    
    func prefetch(urls: [URL]) {
        let prefetcher = ImagePrefetcher(urls: urls) {
            skippedResources, failedResources, completedResources in
        }
        prefetcher.start()
    }
    
    func tappedCard(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if let url = URL(string:movies[0].backdrop) {
                prefetch(urls: [url])
            }
            let nViewController = MovieDetailViewController()
            nViewController.delegate = self
            nViewController.movieListInfo = movies[0]
            navigationController?.pushViewController(nViewController, animated: true)
        }
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
    func loadCards() -> Void {
        if movies.count > 0 {
            let numLoadedCardsCap = movies.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : movies.count
            var urls = [URL]()
            for i in 0 ..< movies.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(movie: movies[i])
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
                if let url  = URL(string: movies[i].image) {
                    urls.append(url)
                }
            }
            prefetch(urls: urls)
            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    v.panelSwipeView.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    v.panelSwipeView.addSubview(loadedCards[i])
                }
                setupConstraintsSubView(Index: i)
            }
        }
    }
    
    func loadSwipe() {
        DataModel.sharedInstance.getMoviesSwipe() {
            (successful, title, msg, res) in
            if successful {
                self.nextUrl = ""
                self.nextUrl.toString(string: res["next"] as Any)
                var urls = [URL]()
                for m in res["results"] as! [[String:Any]] {
                    let movie:MovieListInfo?
                    do {
                        movie = try MovieListInfo(json: m, isSwwipe: true)
                        self.movies.append(movie!)
                        let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(movie: movie!)
                        self.allCards.append(newCard)
                        if let url  = URL(string: movie!.image) {
                            urls.append(url)
                        }
                    } catch  {
                        movie = nil
                    }
                }
                self.prefetch(urls: urls)
            } else {
                
            }
        }
    }
    
    func search() {
        let nViewController = SearchViewController()
        navigationController?.pushViewController(nViewController, animated: true)
    }
    
    func setupConstraintsSubView (Index i: Int) {
        loadedCards[i].translatesAutoresizingMaskIntoConstraints = false
        
        v.panelSwipeView.addConstraint(loadedCards[i].widthAnchor.constraint(equalTo: v.panelSwipeView.heightAnchor, multiplier: 0.7))
        v.panelSwipeView.addConstraint(loadedCards[i].centerXAnchor.constraint(equalTo: v.panelSwipeView.centerXAnchor))
        v.panelSwipeView.addConstraint(loadedCards[i].heightAnchor.constraint(equalTo: v.panelSwipeView.heightAnchor))
        v.panelSwipeView.addConstraint(loadedCards[i].centerYAnchor.constraint(equalTo: v.panelSwipeView.centerYAnchor))
    }
    
    func createDraggableViewWithDataAtIndex(movie: MovieListInfo) -> DraggableView {
        let draggableView = DraggableView()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.tappedCard))
        draggableView.isUserInteractionEnabled = true
        draggableView.addGestureRecognizer(tapGestureRecognizer)
        draggableView.delegate = self
        draggableView.coverView = loadMovieToView(coverView: draggableView.coverView, movie: movie)
        
        return draggableView
    }
    
    func loadMoreCards() {
        var i = loadedCards.count
        while loadedCards.count < MAX_BUFFER_SIZE && i < allCards.count  {
            loadedCards.append(allCards[i])
            v.panelSwipeView.insertSubview(loadedCards[i], belowSubview: loadedCards[i-1])
            setupConstraintsSubView(Index: i)
            i += 1
        }
    }
    
    func afterSwiped() {
        loadedCards.remove(at: 0)
        allCards.remove(at: 0)
        movies.remove(at: 0)
        
        loadMoreCards()
        if allCards.count == MIN_CARDS {
            self.loadSwipe()
        }
    }
    
    func updateTypeMovie(typemovie: TypeMovieModel, movie: MovieListInfo,completion: @escaping (Bool,String,String?) -> Void) {
        if movie.typeMovie == "" {
            DataModel.sharedInstance.insertMovieCollection(idMovie: movie.id, typeMovie: typemovie.hashValue){
                (successful, title, msg, res) in
                self.updateBadgeValue()
                completion(successful, title, msg)
            }
        } else if typemovie.rawValue != movie.typeMovie {
            DataModel.sharedInstance.updateMovieCollection(idCollection: movie.idCollection,typeMovie: typemovie.hashValue){
                (successful, title, msg, res) in
                self.updateBadgeValue()
                completion(successful, title, msg)
            }
        } else {
            completion(true,"","")
            updateBadgeValue()
        }
    }
    
    func cardSwipedLeft(_ card: UIView) -> Void {
        
        updateTypeMovie(typemovie: TypeMovie.watchlist, movie: movies[0]) {
            (successful, title, msg) in
            if !successful {
                Message.msgPopupDelay(title: title, message: msg!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
            }
        }
        self.afterSwiped()
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        
        updateTypeMovie(typemovie: TypeMovie.seen, movie: movies[0]) {
            (successful, title, msg) in
            if !successful {
                Message.msgPopupDelay(title: title, message: msg!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
            }
        }
        self.afterSwiped()
    }
    
    func cardSwipedTop(_ card: UIView) -> Void {
        
        updateTypeMovie(typemovie: TypeMovie.favourite, movie: movies[0]) {
            (successful, title, msg) in
            if !successful {
                Message.msgPopupDelay(title: title, message: msg!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
            }
        }
        self.afterSwiped()
    }
    
    func cardSwipedBottom(_ card: UIView) -> Void {
       
        updateTypeMovie(typemovie: TypeMovie.black, movie: movies[0]) {
        (successful, title, msg) in
            if !successful {
                Message.msgPopupDelay(title: title, message: msg!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
            }
        }
        self.afterSwiped()
    }
    
    func clickSwipeRight() -> Void {
        if loadedCards.count > 0 {
            loadedCards[0].rightAction()
        }
    }
    
    func clickSwipeLeft() -> Void {
        if loadedCards.count > 0 {
            loadedCards[0].leftAction()
        }
    }
    
    func clickSwipeTop() -> Void {
        if loadedCards.count > 0 {
            loadedCards[0].topAction()
        }
    }
    
    func clickSwipeBottom() -> Void {
        if loadedCards.count > 0 {
            loadedCards[0].bottomAction()
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
}
