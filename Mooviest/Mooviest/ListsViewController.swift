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
    
    let user = DataModel.sharedInstance.user
    var v = ListsView()
    var movies = [Movie]()
    let movieCellIdentifier = "movieCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DataModel.sharedInstance.getMoviesSwipe(Lang: 1, Count: 10) {
            (data) in
            
            for m in data {
                let movie = try! MovieParser.jsonToMovie(Movie: m)
                self.movies.append(movie)
            }
            self.setupView()
            self.view.addSubview(self.v)
            self.setupConstraints()
        }
       
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
        nViewController.movie = movies[indexPath.row]
        navigationController?.pushViewController(nViewController, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width/3)-5
        let size = CGSize(width: width, height: width*1.30)
        
        return size
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setupView() {
        v.watchListViewCell.movieCollectionView.delegate = self
        v.watchListViewCell.movieCollectionView.dataSource = self
        v.watchListViewCell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        v.favouriteListViewCell.movieCollectionView.delegate = self
        v.favouriteListViewCell.movieCollectionView.dataSource = self
        v.favouriteListViewCell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        v.seenListViewCell.movieCollectionView.delegate = self
        v.seenListViewCell.movieCollectionView.dataSource = self
        v.seenListViewCell.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        
        v.watchListViewCell.moreButton.addTarget(self, action: #selector(self.tappedMore), for: .touchUpInside)
        v.favouriteListViewCell.moreButton.addTarget(self, action: #selector(self.tappedMore), for: .touchUpInside)
        v.seenListViewCell.moreButton.addTarget(self, action: #selector(self.tappedMore), for: .touchUpInside)
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
    
    func goList(){
        print("list")
    }
}
