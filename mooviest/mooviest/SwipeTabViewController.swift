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
        self.navigationController?.navigationBar.hidden = false
        calculateSizeAndPositionCard()
        v = SwipeTabView(Card_width: CARD_WIDTH, Card_height: CARD_HEIGHT)
        view.addSubview(v)
        setupConstraints()
        DataModel.sharedInstance.getMoviesSwipe(Lang: 1, Count: 10) {
            (data) in
            print(data)
            for m in data {
                
                let movie = try! MovieParser.jsonToMovie(Movie: m)
                self.movies.append(movie)
            }
            print(self.movies[0])
            self.setupView()
        }
    }
    
    func tappedCard(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            
            let index = (sender.view as! DraggableView).index
            print("tapped movie: \(movies[index].originalTitle)")
            let nViewController = MovieDetailViewController()
            nViewController.movie = movies[index]
            navigationController?.pushViewController(nViewController, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        navigationController?.navigationBarHidden = false
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
        
        view.addConstraint(v.leftAnchor.constraintEqualToAnchor(view.leftAnchor))
        view.addConstraint(v.rightAnchor.constraintEqualToAnchor(view.rightAnchor))
        view.addConstraint(v.topAnchor.constraintEqualToAnchor(view.topAnchor))
        view.addConstraint(v.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor))
    }
    
    func setupView() {
        
//        let replayButton = UIButton(type: UIButtonType.Custom) as UIButton
//        
//        replayButton.setImage( UIImage(named: "replay"), forState: UIControlState.Normal)
//        replayButton.tintColor = UIColor.whiteColor()
//        replayButton.addTarget(self, action: #selector(self.replay), forControlEvents: .TouchUpInside)
//
//        let rightBarButton = UIBarButtonItem(customView: replayButton)
//
//        navigationItem.rightBarButtonItem = rightBarButton
        //exampleCardLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        loadCards()
        
        let replayButton = UIBarButtonItem(image: UIImage(named: "replay"),
                                            style: UIBarButtonItemStyle.Plain ,
                                            target: self, action: #selector(self.replay))
        replayButton.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = replayButton
        
        
       
        
        v.closedButton.addTarget(self, action: #selector(self.swipeLeft), forControlEvents: .TouchUpInside)
        v.heartButton.addTarget(self, action: #selector(self.swipeRight), forControlEvents: .TouchUpInside)
        v.clockButton.addTarget(self, action: #selector(self.swipeTop), forControlEvents: .TouchUpInside)
        v.eyeButton.addTarget(self, action: #selector(self.swipeBottom), forControlEvents: .TouchUpInside)
        
    }
    
    func setupConstraintsSubView (Index i: Int) {
        loadedCards[i].translatesAutoresizingMaskIntoConstraints = false
        
        v.addConstraint(loadedCards[i].leftAnchor.constraintEqualToAnchor(v.leftAnchor,constant: 20))
        v.addConstraint(loadedCards[i].topAnchor.constraintEqualToAnchor(v.topAnchor, constant: 60))
        v.addConstraint(loadedCards[i].rightAnchor.constraintEqualToAnchor(v.rightAnchor,constant: -20))
        v.addConstraint(loadedCards[i].bottomAnchor.constraintEqualToAnchor(v.panelButtonView.topAnchor,constant: -20))
        
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
    
    func cardSwipedLeft(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            //setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
            
        }
    }
    
    func cardSwipedRight(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            //setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
            
        }
    }
    
    func cardSwipedTop(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
            //setupConstraintsSubView(Index: MAX_BUFFER_SIZE - 1)
            
        }
    }
    
    func cardSwipedBottom(card: UIView) -> Void {
        loadedCards.removeAtIndex(0)
        
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
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeRight)
        UIView.animateWithDuration(0.2, animations: {
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
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
        UIView.animateWithDuration(0.2, animations: {
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
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeTop)
        UIView.animateWithDuration(0.2, animations: {
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
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeBottom)
        UIView.animateWithDuration(0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.bottomClickAction()
    }
    
    func createDraggableViewWithDataAtIndex(index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRectMake(CGFloat(v.frame.minX + MARGIN_LEFT) , CGFloat(v.frame.minY + MARGIN_TOP), CARD_WIDTH, CARD_HEIGHT), index: index)
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.tappedCard))
        draggableView.userInteractionEnabled = true
        draggableView.addGestureRecognizer(tapGestureRecognizer)
        
        let url = movies[index].image
        
        draggableView.imageView.kf_setImageWithURL(NSURL(string:  url),placeholderImage: UIImage(named:  "noimage"))
        
        draggableView.delegate = self
        return draggableView
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
