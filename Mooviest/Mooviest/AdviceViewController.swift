//
//  AdviceViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 25/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher



class AdviceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
                    MovieProtocol,  TabBarProtocol{
    
    let user = DataModel.sharedInstance.user
    var height:CGFloat!
    var v:ListView!
    var nextUrl = ""
    var movies = [MovieListInfo]()
    var typeMovie =  ""
    let movieCellIdentifier = "movieCollectionViewCell"
    
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
        if indexPath.row == movies.count-10 {
            nextMovies()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetTabBarAndNavigationController(viewController: self)
    }
    
    func reloadList(){
        DataModel.sharedInstance.getMoviesSwipe() {
            (data, next) in
            self.nextUrl = next
            self.movies.removeAll()
            for m in data {
                let movie:MovieListInfo?
                movie = try! MovieListInfo(json: m, isSwwipe: false)
                self.movies.append(movie!)
            }
            self.v.movieCollectionView.reloadData()
        }
    }
    
    func nextMovies(){
        if nextUrl != "" {
            DataModel.sharedInstance.nextMovies(url: nextUrl) {
                (data, next) in
                self.nextUrl = next
                for m in data {
                    let movie:MovieListInfo?
                    movie = try! MovieListInfo(json: m, isSwwipe: false)
                    self.movies.append(movie!)
                }
                self.v.movieCollectionView.reloadData()
            }
        }
    }
    
    func setupView() {
        height = self.navigationController?.navigationBar.frame.height
        v = ListView(heightNavBar: height)
        v.movieCollectionView.delegate = self
        v.movieCollectionView.dataSource = self
        v.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.search))
        searchButton.tintColor = UIColor.white
        let replayButton = UIBarButtonItem(image: UIImage(named: "autorenew"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.reloadList))
        replayButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = replayButton
        navigationItem.rightBarButtonItem = searchButton
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
