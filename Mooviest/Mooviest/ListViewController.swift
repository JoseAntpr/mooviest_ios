//
//  ListViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 12/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//


import UIKit
import Kingfisher



class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
            MovieProtocol, TabBarProtocol, DetailMovieDelegate {
    
    let user = DataModel.sharedInstance.user
    var height:CGFloat!
    var v:ListView!
    var ctrlTitle = ""
    var nextUrl = ""
    var movies = [MovieListInfo]()
    var typeMovie =  ""
    let movieCellIdentifier = "movieCollectionViewCell"
    var delegate:DetailMovieDelegate?
    
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
        if indexPath.row == movies.count-10 {
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
            (successful, title, msg, res) in
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
                    
                }
            } else {
                
            }
        }
    }
    
    func nextMovies(){
        if nextUrl != "" {
            DataModel.sharedInstance.nextMovies(url: nextUrl) {
                (successful, title, msg, res) in
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
                        
                    }
                } else {
                    
                }
            }
        }
    }
    
    func setupView() {
        height = self.navigationController?.navigationBar.frame.height
        v = ListView(heightNavBar: height)
        v.movieCollectionView.delegate = self
        v.movieCollectionView.dataSource = self
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
    
    func goList(){
        print("list")
    }
}
