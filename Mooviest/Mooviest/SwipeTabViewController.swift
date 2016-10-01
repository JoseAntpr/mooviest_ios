
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
    //var exampleCardLabels: [String]!
    var allCards: [DraggableView]!
    let MAX_BUFFER_SIZE = 2
    var FRAME_HEIGHT = CGFloat(530)
    var FRAME_WIDTH = CGFloat(375)
    var CARD_HEIGHT = CGFloat()
    var CARD_WIDTH = CGFloat()
    var MARGIN_TOP = CGFloat()
    var MARGIN_LEFT = CGFloat()
    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        calculateSizeAndPositionCard()
        v = SwipeTabView(Card_width: CARD_WIDTH, Card_height: CARD_HEIGHT)
        view.addSubview(v)
        setupConstraints()
        DataModel.sharedInstance.getMoviesSwipe(Lang: 1, Count: 10) {
            (data) in
            
            for m in data {
                let movie = try! MovieParser.jsonToMovie(Movie: m)
                self.movies.append(movie)
            }
//            print(self.movies[0])
            self.setupView()
        }
    }
    
    func tappedCard(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            
            let index = (sender.view as! DraggableView).index
            print("tapped movie: \(movies[index!].originalTitle)")
            let nViewController = MovieDetailViewController()
            nViewController.movie = movies[index!]
            navigationController?.pushViewController(nViewController, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        navigationController?.isNavigationBarHidden = false
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateSizeAndPositionCard() {
        FRAME_HEIGHT = self.view.frame.size.height
        FRAME_WIDTH = self.view.frame.size.width
        CARD_HEIGHT = FRAME_HEIGHT * 0.68
        CARD_WIDTH = FRAME_WIDTH * 0.87
        MARGIN_LEFT = (FRAME_WIDTH * 0.13) / 2
        MARGIN_TOP = (FRAME_HEIGHT * 0.27) / 2
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
        
        v.closedButton.addTarget(self, action: #selector(self.swipeLeft), for: .touchUpInside)
        v.heartButton.addTarget(self, action: #selector(self.swipeRight), for: .touchUpInside)
        v.clockButton.addTarget(self, action: #selector(self.swipeTop), for: .touchUpInside)
        v.eyeButton.addTarget(self, action: #selector(self.swipeBottom), for: .touchUpInside)
        
    }
    
    func setupConstraintsSubView (Index i: Int) {
        loadedCards[i].translatesAutoresizingMaskIntoConstraints = false
        
        v.addConstraint(loadedCards[i].leftAnchor.constraint(equalTo: v.leftAnchor,constant: 20))
        v.addConstraint(loadedCards[i].topAnchor.constraint(equalTo: v.topAnchor, constant: 60))
        v.addConstraint(loadedCards[i].rightAnchor.constraint(equalTo: v.rightAnchor,constant: -20))
        v.addConstraint(loadedCards[i].bottomAnchor.constraint(equalTo: v.panelButtonView.topAnchor,constant: -20))
    }
    
    func replay() {
        print("replay")
        for card in loadedCards {
            card.removeFromSuperview()
        }
        
        // exampleCardLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        allCards = []
        cardsLoadedIndex = 0
        loadedCards = []
        loadCards()
    }
    
    
    func loadCards() -> Void {
        if movies.count > 0 {
            let numLoadedCardsCap = movies.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : movies.count
            for i in 0 ..< movies.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                print("create " + movies[i].originalTitle)
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
            }
            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    v.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    v.addSubview(loadedCards[i])
                }
                //setupConstraintsSubView(Index: i)
                print("chargue \(i)")
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }
    
    func cardSwipedLeft(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            //setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
            
        }
    }
    
    func cardSwipedRight(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            //setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
            
        }
    }
    
    func cardSwipedTop(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            //setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
            
        }
    }
    
    func cardSwipedBottom(_ card: UIView) -> Void {
        loadedCards.remove(at: 0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            //setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
            
        }
    }
    
    func swipeRight() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    func swipeLeft() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
    
    func swipeTop() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeTop)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.topClickAction()
    }
    
    func swipeBottom() -> Void {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: DraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeBottom)
        UIView.animate(withDuration: 0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.bottomClickAction()
    }
    
    func createDraggableViewWithDataAtIndex(_ index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRect(x: CGFloat(v.frame.minX + MARGIN_LEFT) , y: CGFloat(v.frame.minY + MARGIN_TOP), width: CARD_WIDTH, height: CARD_HEIGHT), index: index)
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.tappedCard))
        draggableView.isUserInteractionEnabled = true
        draggableView.addGestureRecognizer(tapGestureRecognizer)
        
        let url = movies[index].image
        
        draggableView.imageView.kf_setImage(with: URL(string:  url),placeholder: UIImage(named:  "noimage"))
        
        draggableView.delegate = self
        return draggableView
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
