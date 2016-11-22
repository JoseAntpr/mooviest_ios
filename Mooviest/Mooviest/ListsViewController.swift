//
//  ListViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 11/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher

class ListsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
                MovieProtocol, TabBarProtocol, DetailMovieDelegate {
    var height:CGFloat!
    let user = DataModel.sharedInstance.user
    
    var v: ListsView!
    var nextUrl = ["","","","",""]
    var lists = [[MovieListInfo](), [MovieListInfo](),
        [MovieListInfo](),[MovieListInfo](),[MovieListInfo]()]
    let movieCellIdentifier = "movieCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.view.addSubview(v)
        self.setupConstraints()
        reloadLists()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func getList(collectionView: UICollectionView)->[MovieListInfo] {
        var list:[MovieListInfo]!
        
        switch collectionView {
            case v.watchListViewCell.movieCollectionView: list = lists[TypeMovie.watchlist.hashValue-1]
            case v.favouriteListViewCell.movieCollectionView: list = lists[TypeMovie.favourite.hashValue-1]
            case v.seenListViewCell.movieCollectionView: list = lists[TypeMovie.seen.hashValue-1]
            default: list = lists[TypeMovie.black.hashValue-1]
        }
        return list
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = getList(collectionView: collectionView)[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        cell.coverView = loadMovieToView(coverView: cell.coverView, movie: movie)
        cell.coverView.layer.cornerRadius = 5
        cell.coverView.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = getList(collectionView: collectionView).count
        if let item = collectionView.superview as? ItemListView {
            item.emptyLabel.alpha = count == 0 ? 1:0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nViewController = MovieDetailViewController()
        nViewController.delegate = self
        nViewController.movieListInfo = getList(collectionView: collectionView)[indexPath.item]
        navigationController?.pushViewController(nViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let size = CGSize(width: height*0.7, height: height)
        
        return size
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetTabBarAndNavigationController(viewController: self)
        if let value = tabBarController?.tabBar.items?[1].badgeValue {
            if value != "" {
                reloadLists()
                tabBarController?.tabBar.items?[1].badgeValue = nil
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        v.adjustFontSizeToFitHeight()
    }
    
    func updateClasificationMovie(_ movie: Movie) {
        reloadLists()
    }
    
    func reloadLists() {
        reloadList(typemovie: TypeMovie.watchlist, collection: v.watchListViewCell.movieCollectionView)
        reloadList(typemovie: TypeMovie.favourite, collection: v.favouriteListViewCell.movieCollectionView)
        reloadList(typemovie: TypeMovie.seen, collection: v.seenListViewCell.movieCollectionView)
        reloadList(typemovie: TypeMovie.black, collection: v.blackListViewCell.movieCollectionView)
    }
    
    func reloadList(typemovie: TypeMovieModel, collection: UICollectionView) {
        DataModel.sharedInstance.getMovieList(listname: typemovie.rawValue) {
            successful, title, message, res in
            if successful {
                do {
                    let indexList = typemovie.hashValue-1
                    self.nextUrl[indexList] = ""
                    self.nextUrl[indexList].toString(string: res["next"] as Any)
                    self.lists[indexList].removeAll()
                    
                    for m in res["results"] as! [[String:Any]] {
                        let movie:MovieListInfo?
                        movie = try MovieListInfo(json: m, isSwwipe: false)
                        self.lists[indexList].append(movie!)
                    }
                    collection.reloadData()
                } catch {
                    let title = NSLocalizedString("getListTitle", comment: "Title of searchMoviesByCelebrity")
                    let msg = NSLocalizedString("getListMsg", comment: "Message of searchMoviesByCelebrity")
                    Message.msgPopupDelay(title: title, message: msg, delay: 0, ctrl: self) {}
                }
            } else {
                Message.msgPopupDelay(title: title, message: message!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
            }
        }
    }
    
    func setupView() {
        tabBarController?.tabBar.items?[1].badgeValue = nil
        height = self.navigationController?.navigationBar.frame.height
        v = ListsView(heightNavBar: height)
        
        v.watchListViewCell.movieCollectionView.delegate = self
        v.watchListViewCell.movieCollectionView.dataSource = self
        v.watchListViewCell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        v.favouriteListViewCell.movieCollectionView.delegate = self
        v.favouriteListViewCell.movieCollectionView.dataSource = self
        v.favouriteListViewCell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        v.seenListViewCell.movieCollectionView.delegate = self
        v.seenListViewCell.movieCollectionView.dataSource = self
        v.seenListViewCell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        v.blackListViewCell.movieCollectionView.delegate = self
        v.blackListViewCell.movieCollectionView.dataSource = self
        v.blackListViewCell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.search))
        searchButton.tintColor = mooviest_red
        let replayButton = UIBarButtonItem(image: UIImage(named: "autorenew"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.reloadLists))
        replayButton.tintColor = mooviest_red
        navigationItem.leftBarButtonItem = replayButton
        navigationItem.rightBarButtonItem = searchButton
    
        v.watchListViewCell.moreButton.addTarget(self, action: #selector(self.tappedWatchListMore), for: .touchUpInside)
        v.favouriteListViewCell.moreButton.addTarget(self, action: #selector(self.tappedFavouriteListMore), for: .touchUpInside)
        v.seenListViewCell.moreButton.addTarget(self, action: #selector(self.tappedSeenListMore), for: .touchUpInside)
        v.blackListViewCell.moreButton.addTarget(self, action: #selector(self.tappedBlackListMore), for: .touchUpInside)
    }
    
    func tappedMore(typemovie: TypeMovieModel){
        let nViewController = ListViewController()
        nViewController.delegate = self
        nViewController.ctrlTitle = typemovie.title
        nViewController.typeMovie = typemovie.rawValue
        nViewController.nextUrl = nextUrl[typemovie.hashValue-1]
        navigationController?.pushViewController(nViewController, animated: true)
    }
    
    func tappedWatchListMore()  {
        tappedMore(typemovie: TypeMovie.watchlist)
    }
    
    func tappedFavouriteListMore()  {
        tappedMore(typemovie: TypeMovie.favourite)
    }
    
    func tappedSeenListMore()  {
        tappedMore(typemovie: TypeMovie.seen)
    }
    
    func tappedBlackListMore()  {
        tappedMore(typemovie: TypeMovie.black)
    }
    
    func search() {
        let nViewController = SearchViewController()
        navigationController?.pushViewController(nViewController, animated: true)
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
}
