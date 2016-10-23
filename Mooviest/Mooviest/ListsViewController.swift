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
    var movies = [MovieListInfo]()
    let movieCellIdentifier = "movieCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataModel.sharedInstance.getMovieList(listname: "watchlist", page: 1) {
            (data) in
            print(data)
            for m in data {
                let movie:MovieListInfo?
                movie = try! MovieListInfo(json: m)
                self.movies.append(movie!)
            }
            self.v.favouriteListViewCell.movieCollectionView.reloadData()
            self.v.watchListViewCell.movieCollectionView.reloadData()
            self.v.seenListViewCell.movieCollectionView.reloadData()
            self.v.blackListViewCell.movieCollectionView.reloadData()
        }
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
        var cell:UICollectionViewCell!
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        
        switch collectionView {
        case v.watchListViewCell.movieCollectionView:
            let url = URL(string: movies[indexPath.item].image)
            customCell.movieImageView.kf_setImage(with: url,placeholder: UIImage(named:  "noimage"))
            cell = customCell
        case v.favouriteListViewCell.movieCollectionView:
            let url = URL(string: movies[indexPath.item].image)
            customCell.movieImageView.kf_setImage(with: url,placeholder: UIImage(named:  "noimage"))
            cell = customCell
        default:
            let url = URL(string: movies[indexPath.item].image)
            customCell.movieImageView.kf_setImage(with: url,placeholder: UIImage(named:  "noimage"))
            cell = customCell
        }
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        switch collectionView {
        case v.watchListViewCell.movieCollectionView:
            count = movies.count
        case v.favouriteListViewCell.movieCollectionView:
            count = movies.count
        default:
           count = movies.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nViewController = MovieDetailViewController()
        nViewController.movieListInfo = movies[indexPath.row]
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
            nViewController.movies = movies
        case v.favouriteListViewCell.moreButton:
            nViewController.movies = movies
        default:
            nViewController.movies = movies
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
