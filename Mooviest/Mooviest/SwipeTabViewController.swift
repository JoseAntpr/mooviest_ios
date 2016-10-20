
//
//  SwipeTabViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit
import Kingfisher

class SwipeTabViewController: UIViewController, DraggableViewDelegate {
    var v: SwipeTabView!
    var allCards: [DraggableView]!
    let MAX_BUFFER_SIZE = 2
    var cardsLoadedIndex: Int!
    var loadedCards = [DraggableView]()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let height = self.navigationController?.navigationBar.frame.height
        v = SwipeTabView(heightNavBar: height!)
        view.addSubview(v)
        setupConstraints()
        DataModel.sharedInstance.getMoviesSwipe(Lang: 1, Count: 10) {
            (data) in
            
            for m in data {
                let movie:Movie?
                do {
                    movie = try MovieParser.jsonToMovie(Movie: m)
                    self.movies.append(movie!)
                } catch ErrorMovie.invalidMovie {
                    movie = nil
                }
            }
            self.setupView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
    }
    
    func tappedCard(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let index = (sender.view as! DraggableView).index
            let nViewController = MovieDetailViewController()
            nViewController.movie = movies[index!]
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
    
    func setupView() {
        
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        loadCards()
        
        let replayButton = UIBarButtonItem(image: UIImage(named: "replay"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action: #selector(self.replay))
        replayButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = replayButton
        
        v.closedButton.addTarget(self, action: #selector(self.clickSwipeLeft), for: .touchUpInside)
        v.heartButton.addTarget(self, action: #selector(self.clickSwipeRight), for: .touchUpInside)
        v.clockButton.addTarget(self, action: #selector(self.clickSwipeTop), for: .touchUpInside)
        v.eyeButton.addTarget(self, action: #selector(self.clickSwipeBottom), for: .touchUpInside)
    }
    
    func setupConstraintsSubView (Index i: Int) {
        loadedCards[i].translatesAutoresizingMaskIntoConstraints = false
        
        v.panelSwipeView.addConstraint(loadedCards[i].widthAnchor.constraint(equalTo: v.panelSwipeView.heightAnchor, multiplier: 0.7))
        v.panelSwipeView.addConstraint(loadedCards[i].centerXAnchor.constraint(equalTo: v.panelSwipeView.centerXAnchor))
        v.panelSwipeView.addConstraint(loadedCards[i].heightAnchor.constraint(equalTo: v.panelSwipeView.heightAnchor))
        v.panelSwipeView.addConstraint(loadedCards[i].centerYAnchor.constraint(equalTo: v.panelSwipeView.centerYAnchor))
    }
    
    func replay() {//Finally, i will used for chargue more movie in the swipe
        for card in loadedCards {
            card.removeFromSuperview()
        }
        allCards = []
        cardsLoadedIndex = 0
        loadedCards = []
        loadCards()
    }
    
    func createDraggableViewWithDataAtIndex(_ index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(index: index)
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.tappedCard))
        draggableView.isUserInteractionEnabled = true
        draggableView.addGestureRecognizer(tapGestureRecognizer)
        
        let url = movies[index].image
        
        draggableView.imageView.kf_setImage(with: URL(string:  url),placeholder: UIImage(named:  "noimage"))        
        draggableView.delegate = self
        return draggableView
    }
    
    func loadCards() -> Void {
        if movies.count > 0 {
            let numLoadedCardsCap = movies.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : movies.count
            for i in 0 ..< movies.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
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
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }
    
    func afterSwiped() {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.panelSwipeView.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
        }
    }
    func cardSwipedLeft(_ card: UIView) -> Void {
        //update db before remove card
        afterSwiped()
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        //update db before remove card
        afterSwiped()
    }
    
    func cardSwipedTop(_ card: UIView) -> Void {
        //update db before remove card
        afterSwiped()
    }
    
    func cardSwipedBottom(_ card: UIView) -> Void {
        //update db before remove card
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
