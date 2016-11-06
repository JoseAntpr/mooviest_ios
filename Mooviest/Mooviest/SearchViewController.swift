//
//  SearchViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 23/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher



class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, MovieProtocol,TabBarProtocol,
    UICollectionViewDataSourcePrefetching {
    
    let user = DataModel.sharedInstance.user
    var height:CGFloat!
    var v:ListView!
    let searchBar = UISearchBar()
    var nextUrl = ""
    var movies = [MovieListInfo]()
    let movieCellIdentifier = "movieCollectionViewCell"
    var isIOS10 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let width = (collectionView.frame.width-2)/3
        let size = CGSize(width: width, height: width*1.42)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath){
        if !isIOS10 {
            if (movies.count-indexPath.row) < 10 {
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
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.resetTabBarAndNavigationController(viewController: self)
//        searchBar.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setupView() {
        height = self.navigationController?.navigationBar.frame.height
        v = ListView(heightNavBar: height)
        v.movieCollectionView.delegate = self
        v.movieCollectionView.dataSource = self
        v.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        if #available(iOS 10.0, *) {
//            v.movieCollectionView.prefetchDataSource = self
//            isIOS10 = true
        }
    }
    
    func nextMovies(){
        if nextUrl != "" {
            let urlnext = nextUrl
            nextUrl = ""
            print(urlnext)
            DataModel.sharedInstance.nextMovies(url: urlnext) {
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
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movies.removeAll()
        DataModel.sharedInstance.searchMovies(name: searchBar.text!) {
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
                    self.v.movieCollectionView.contentOffset.y = 0
                    self.v.movieCollectionView.reloadData()
                } catch {
                    print("falla el parser  \(title) \n \(msg)")
                }
            } else {
                print("falla el servidor \(title) \n \(msg)")
            }
        }
        
        searchBar.resignFirstResponder()
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
}
