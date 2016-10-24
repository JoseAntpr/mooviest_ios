//
//  SearchViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 23/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit
import Kingfisher



class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    let user = DataModel.sharedInstance.user
    var height:CGFloat!
    var v:SearchView!
    var nextUrl = ""
    var movies = [MovieListInfo]()
    let movieCellIdentifier = "movieCollectionViewCell"
    
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
        
        let url = URL(string: movies[indexPath.item].image)
        cell.movieImageView.kf_setImage(with: url,placeholder: UIImage(named:  "noimage"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("salta")
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
        if indexPath.row == movies.count-10 {
            nextMovies()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setupView() {
        height = self.navigationController?.navigationBar.frame.height
        v = SearchView(heightNavBar: height)
        v.movieCollectionView.delegate = self
        v.movieCollectionView.dataSource = self
        v.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellIdentifier)
        v.searchBar.delegate = self
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
//        view.addGestureRecognizer(tap)
    }
    
    func nextMovies(){
        if nextUrl != "" {
            DataModel.sharedInstance.nextMovies(url: nextUrl) {
                (data, next) in
                self.nextUrl = next
                for m in data {
                    let movie:MovieListInfo?
                    movie = try! MovieListInfo(json: m)
                    self.movies.append(movie!)
                }
                //guardar offset
                self.v.movieCollectionView.reloadData()
                //poner offset guardado
            }
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DataModel.sharedInstance.searchMovies(name: searchBar.text!) {
            (data, next) in
            self.nextUrl = next
            for m in data {
                let movie:MovieListInfo?
                movie = try! MovieListInfo(json: m)
                self.movies.append(movie!)
            }
            self.v.movieCollectionView.contentOffset.y = 0
            self.v.movieCollectionView.reloadData()
        }
        movies.removeAll()
        searchBar.resignFirstResponder()
    }
    
    // keyboard
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)            
        }
    }
    
    func setupConstraints() {
        v.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(v.leftAnchor.constraint(equalTo: view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraint(equalTo: view.rightAnchor))
        view.addConstraint(v.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
}
