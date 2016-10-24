//
//  ListViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 11/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher

class ListsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var height:CGFloat!
    let user = DataModel.sharedInstance.user
    
    var v: ListsView!
    var watchList = [MovieListInfo]()
    var nextWatch = ""
    var favouriteList = [MovieListInfo]()
    var nextFavourite = ""
    var seenList = [MovieListInfo]()
    var nextSeen = ""
    var blackList = [MovieListInfo]()
    var nextBlack = ""
    let movieCellIdentifier = "movieCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadList()
        self.setupView()
        self.view.addSubview(self.v)
        self.setupConstraints()
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
            case v.watchListViewCell.movieCollectionView: list = watchList
            case v.favouriteListViewCell.movieCollectionView: list = favouriteList
            case v.seenListViewCell.movieCollectionView: list = seenList
            default: list = blackList
        }
        return list
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = getList(collectionView: collectionView)[indexPath.item].image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        cell.movieImageView.kf_setImage(with: URL(string: image),placeholder: UIImage(named:  "noimage"))
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getList(collectionView: collectionView).count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nViewController = MovieDetailViewController()
        nViewController.movieListInfo = getList(collectionView: collectionView)[indexPath.item]
        navigationController?.pushViewController(nViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let size = CGSize(width: height*0.7, height: height)
        
        return size
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
        reloadList()
    }
    
    func reloadList(){
        DataModel.sharedInstance.getMovieList(listname: TypeMovie.watchlist.rawValue) {
            (data, next) in
            self.nextWatch = next
            self.watchList.removeAll()
            for m in data {
                let movie:MovieListInfo?
                movie = try! MovieListInfo(json: m)
                self.watchList.append(movie!)
            }
            self.v.watchListViewCell.movieCollectionView.reloadData()
        }
        
        DataModel.sharedInstance.getMovieList(listname: TypeMovie.favourite.rawValue) {
            (data,next) in
            self.nextFavourite = next
            self.favouriteList.removeAll()
            for m in data {
                let movie:MovieListInfo?
                movie = try! MovieListInfo(json: m)
                self.favouriteList.append(movie!)
            }
            self.v.favouriteListViewCell.movieCollectionView.reloadData()
        }
        
        DataModel.sharedInstance.getMovieList(listname: TypeMovie.seen.rawValue) {
            (data,next) in
            self.nextSeen = next
            self.seenList.removeAll()
            for m in data {
                let movie:MovieListInfo?
                movie = try! MovieListInfo(json: m)
                self.seenList.append(movie!)
            }
            self.v.seenListViewCell.movieCollectionView.reloadData()
        }
        
        DataModel.sharedInstance.getMovieList(listname: TypeMovie.black.rawValue) {
            (data,next) in
            self.nextBlack = next
            self.blackList.removeAll()
            for m in data {
                let movie:MovieListInfo?
                movie = try! MovieListInfo(json: m)
                self.blackList.append(movie!)
            }
            self.v.blackListViewCell.movieCollectionView.reloadData()
        }
    }
    
    func setupView() {
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
    
        v.watchListViewCell.moreButton.addTarget(self, action: #selector(self.tappedMore), for: .touchUpInside)
        v.favouriteListViewCell.moreButton.addTarget(self, action: #selector(self.tappedMore), for: .touchUpInside)
        v.seenListViewCell.moreButton.addTarget(self, action: #selector(self.tappedMore), for: .touchUpInside)
        v.blackListViewCell.moreButton.addTarget(self, action: #selector(self.tappedMore), for: .touchUpInside)
    }
    
    func tappedMore(button:UIButton)  {
        let nViewController = ListViewController()
        
        switch button {
        case v.watchListViewCell.moreButton:
            nViewController.typeMovie = TypeMovie.watchlist.rawValue
            nViewController.nextUrl = nextWatch
        case v.favouriteListViewCell.moreButton:
            nViewController.typeMovie = TypeMovie.favourite.rawValue
            nViewController.nextUrl = nextFavourite
        case v.seenListViewCell.moreButton:
            nViewController.typeMovie = TypeMovie.seen.rawValue
            nViewController.nextUrl = nextSeen
        default:
            nViewController.typeMovie = TypeMovie.black.rawValue
            nViewController.nextUrl = nextBlack
        }
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
