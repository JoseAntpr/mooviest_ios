
//
//  SwipeTabViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit
import Kingfisher

class SwipeTabViewController: UIViewController, DraggableViewDelegate, CoverMovieProtocol {
    var v: SwipeTabView!
    var allCards: [DraggableView]!
    let MAX_BUFFER_SIZE = 2
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
        DataModel.sharedInstance.getMoviesSwipe() {
            (data, next) in
            self.nextUrl = next
            self.movies.removeAll()
            for m in data {
                let movie:MovieListInfo?
                do {
                    movie = try MovieListInfo(json: m, isSwwipe: true)
                    self.movies.append(movie!)
                } catch ErrorMovie.invalidMovie {
                    movie = nil
                }
            }
            self.allCards = []
            self.loadedCards = []
            self.loadCards()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
    }
    
    func tappedCard(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let nViewController = MovieDetailViewController()
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
            for i in 0 ..< movies.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(movie: movies[i])
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
            }
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
            (data, next) in
            self.nextUrl = next
            for m in data {
                let movie:MovieListInfo?
                do {
                    movie = try MovieListInfo(json: m, isSwwipe: true)
                    self.movies.append(movie!)
                    let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(movie: movie!)
                    self.allCards.append(newCard)
                } catch ErrorMovie.invalidMovie {
                    movie = nil
                }
            }
        }
    }
    
    func setupView() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"),
                                         style: UIBarButtonItemStyle.plain ,
                                         target: self, action: #selector(self.search))
        searchButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = searchButton
        v.closedButton.addTarget(self, action: #selector(self.clickSwipeLeft), for: .touchUpInside)
        v.heartButton.addTarget(self, action: #selector(self.clickSwipeRight), for: .touchUpInside)
        v.clockButton.addTarget(self, action: #selector(self.clickSwipeTop), for: .touchUpInside)
        v.eyeButton.addTarget(self, action: #selector(self.clickSwipeBottom), for: .touchUpInside)
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
    
    
    func afterSwiped() {
        loadedCards.remove(at: 0)
        allCards.remove(at: 0)
        movies.remove(at: 0)
        
        if loadedCards.count > 0 {
            loadedCards.append(allCards[1])
            v.panelSwipeView.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
        }
        if allCards.count == 5 {
            loadSwipe()
        }
    }
    
    func updateTypeMovie(typemovie: Int) {
        var movie = movies[0]
        if movie.typeMovie == "" {//insert Collection
            DataModel.sharedInstance.insertMovieCollection(idMovie: movie.id, typeMovie: typemovie+1){
                (res) in
                if let id = res["id"] as? Int {
                    movie.idCollection = id
                    if let typeMovie = res["typeMovie"] as? String {
                        movie.typeMovie = typeMovie
                    }
                }
            }
        } else {
            DataModel.sharedInstance.updateMovieCollection(idCollection: movie.idCollection,typeMovie: typemovie+1){
                (res) in
                print(res)
                if let id = res["id"] as? Int {
                    movie.idCollection = id
                    if let typeMovie = res["typeMovie"] as? String {
                        movie.typeMovie = typeMovie
                    }
                }
            }
        }
        movies[0] = movie
    }
    
    func selectTypeMovie(button: UIButton) {
        button.tintColor = UIColor(netHex: mooviest_red)
        
        switch button {
        case v.clockButton:
            updateTypeMovie(typemovie: TypeMovie.watchlist.hashValue)
        case v.heartButton:
            updateTypeMovie(typemovie: TypeMovie.favourite.hashValue)
        case v.eyeButton:
            updateTypeMovie(typemovie: TypeMovie.seen.hashValue)
        default:
            updateTypeMovie(typemovie: TypeMovie.black.hashValue)
        }
    }

    func cardSwipedLeft(_ card: UIView) -> Void {
        updateTypeMovie(typemovie: TypeMovie.black.hashValue)
        afterSwiped()
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        updateTypeMovie(typemovie: TypeMovie.favourite.hashValue)
        afterSwiped()
    }
    
    func cardSwipedTop(_ card: UIView) -> Void {
        updateTypeMovie(typemovie: TypeMovie.watchlist.hashValue)
        afterSwiped()
    }
    
    func cardSwipedBottom(_ card: UIView) -> Void {
        updateTypeMovie(typemovie: TypeMovie.seen.hashValue)
        afterSwiped()
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
        return UIStatusBarStyle.lightContent
    }
}
