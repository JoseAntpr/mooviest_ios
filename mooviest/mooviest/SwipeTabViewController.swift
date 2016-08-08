//
//  SwipeTabViewController.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit

class SwipeTabViewController: UIViewController, DraggableViewDelegate {
    var v = SwipeTabView()
    
    var exampleCardLabels: [String]!
    var allCards: [DraggableView]!
    
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = 530
    let CARD_WIDTH: CGFloat = 375
    
    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(v)
        setupConstraints()
        setupView()
        
    }
    
    override func didReceiveMemoryWarning() {
        navigationController?.navigationBarHidden = false
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        exampleCardLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
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

        exampleCardLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        allCards = []
        cardsLoadedIndex = 0
        loadedCards = []
        loadCards()
    }
    
    
    func loadCards() -> Void {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for i in 0 ..< exampleCardLabels.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                print("create " + exampleCardLabels[i] )
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
    
    func createDraggableViewWithDataAtIndex(index: NSInteger) -> DraggableView {
        let draggableView = DraggableView(frame: CGRectMake(CGFloat(v.frame.minX + 20), CGFloat(v.frame.minY + 80), CARD_WIDTH, CARD_HEIGHT))
        draggableView.imageView.image = UIImage(named: exampleCardLabels[index])
        draggableView.delegate = self
        return draggableView
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
