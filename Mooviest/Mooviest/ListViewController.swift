//
//  ListViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 12/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//


import UIKit
import Kingfisher



class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,MovieProtocol, TabBarProtocol, DetailMovieDelegate,
    UICollectionViewDataSourcePrefetching {
    let MIN_MOVIES = 10
    let user = DataModel.sharedInstance.user
    var height:CGFloat!
    var v:ListView!
    var ctrlTitle = ""
    var nextUrl = ""
    var movies = [MovieListInfo]()
    var typeMovie =  ""
    let movieCellIdentifier = "movieCollectionViewCell"
    var delegate:DetailMovieDelegate?
    var isIOS10 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.view.addSubview(self.v)
        self.setupConstraints()
        reloadList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        cell.coverView = loadMovieToView(coverView: cell.coverView, movie: movies[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nViewController = MovieDetailViewController()
        nViewController.delegate = self
        nViewController.movieListInfo = movies[indexPath.row]
        navigationController?.pushViewController(nViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width/3)-1
        let size = CGSize(width: width, height: width*1.30)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath){
        
        if !isIOS10 {
            if (movies.count-indexPath.row) < MIN_MOVIES {
                nextMovies()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        var urls = [URL]()
        for indexPath in indexPaths {
            let image = movies[indexPath.item].image
            if image != ""{
                urls.append(URL(string: image)!)
            }
        }
        ImagePrefetcher(urls: urls).start()
        if (movies.count - (indexPaths.last?.item)!) < indexPaths.count {
            nextMovies()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetTabBarAndNavigationController(viewController: self)
    }
    
    func updateClasificationMovie(_ movie: Movie) {
        if typeMovie != movie.typeMovie {
            reloadList()
            delegate?.updateClasificationMovie(movie)
        }
    }
    
    func reloadList(){
        DataModel.sharedInstance.getMovieList(listname: typeMovie) {
            successful, title, message, res in
            if successful {
                do {
                    self.nextUrl = ""
                    self.nextUrl.toString(string: res["next"] as Any)
                    self.movies.removeAll()
        
                    for m in res["results"] as! [[String:Any]] {
                        let movie:MovieListInfo?
                        movie = try MovieListInfo(json: m, isSwwipe: false)
                        self.movies.append(movie!)
                        
                    }
                    self.v.movieCollectionView.reloadData()
                } catch {
                    let title = NSLocalizedString("getListTitle", comment: "Title of getMovieList")
                    let msg = NSLocalizedString("getListMsg", comment: "Message of getMovieList")
                    Message.msgPopupDelay(title: title, message:msg, delay: 0, ctrl: self) {}
                }
            } else {
                Message.msgPopupDelay(title: title, message: message!, delay: 0, ctrl: self) {
                    DataModel.sharedInstance.errorConnetion(title:title)
                }
            }
        }
    }
    
    func nextMovies(){
        if nextUrl != "" {
            let urlnext = nextUrl
            nextUrl = ""
            DataModel.sharedInstance.nextMovies(url: urlnext) {
                successful, title, message, res in
                if successful {
                    do {
                        self.nextUrl = ""
                        self.nextUrl.toString(string: res["next"] as Any)
                        for m in res["results"] as! [[String:Any]] {
                            let movie:MovieListInfo?
                            movie = try MovieListInfo(json: m, isSwwipe: false)
                            self.movies.append(movie!)
                        }
                        self.v.movieCollectionView.reloadData()
                    } catch {
                        let title = NSLocalizedString("getNextPageListTitle", comment: "Title of nextMovies")
                        let msg = NSLocalizedString("getNextPageListMsg", comment: "Message of nextMovies")
                        Message.msgPopupDelay(title: title, message:msg, delay: 0, ctrl: self) {}
                    }
                } else {
                    Message.msgPopupDelay(title: title, message: message!, delay: 0, ctrl: self) {
                        DataModel.sharedInstance.errorConnetion(title:title)
                    }
                }
            }
        }
    }
    
    func setupView() {
        height = self.navigationController?.navigationBar.frame.height
        v = ListView(heightNavBar: height)
        v.movieCollectionView.delegate = self
        v.movieCollectionView.dataSource = self
        if #available(iOS 10.0, *) {
//            v.movieCollectionView.prefetchDataSource = self
//            isIOS10 = true
        }
        v.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        navigationItem.title = ctrlTitle
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
}
