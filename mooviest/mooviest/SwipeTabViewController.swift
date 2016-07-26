//
//  SwipeTabViewController.swift
//  mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Antonio RG. All rights reserved.
//

import UIKit

class SwipeTabViewController: UIViewController, DraggableViewDelegate {
    //var v = SwipeTabView()
    var v = SwipeTabView()
    
    var exampleCardLabels: [String]!
    var allCards: [DraggableView]!
    
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = 500
    let CARD_WIDTH: CGFloat = 370
       
    var cardsLoadedIndex: Int!
    var loadedCards: [DraggableView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(v)
        setupConstraints()
        setupView()
        
    }
    
    override func didReceiveMemoryWarning() {
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
        
        UITabBar.appearance().barTintColor = UIColor(netHex: 0x940224)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        exampleCardLabels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        loadCards()
        
        v.closedButton.addTarget(self, action: #selector(self.swipeLeft), forControlEvents: .TouchUpInside)
        v.heartButton.addTarget(self, action: #selector(self.swipeRight), forControlEvents: .TouchUpInside)
        v.replayButton.addTarget(self, action: #selector(self.replay), forControlEvents: .TouchUpInside)
    }
    
    func setupConstraintsSubView (Index i: Int) {
        loadedCards[i].translatesAutoresizingMaskIntoConstraints = false
        
        v.addConstraint(loadedCards[i].leftAnchor.constraintEqualToAnchor(v.leftAnchor,constant: 20))
        v.addConstraint(loadedCards[i].topAnchor.constraintEqualToAnchor(v.topAnchor, constant: 60))
        v.addConstraint(loadedCards[i].rightAnchor.constraintEqualToAnchor(v.rightAnchor,constant: -20))
        v.addConstraint(loadedCards[i].bottomAnchor.constraintEqualToAnchor(v.panelButtonView.topAnchor,constant: -20))
    
    }
    
    func replay() {
        loadedCards = []
        cardsLoadedIndex = 0
        loadedCards.append(allCards[cardsLoadedIndex])
        cardsLoadedIndex = cardsLoadedIndex + 1
        loadedCards.append(allCards[cardsLoadedIndex])
        v.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
    }
    
    
    func loadCards() -> Void {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for i in 0 ..< exampleCardLabels.count {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
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
        let draggableView = DraggableView(frame: CGRectMake(CGFloat(v.frame.maxX + 20), CGFloat(v.frame.maxY + 90), CARD_WIDTH, CARD_HEIGHT))
        draggableView.imageView.image = UIImage(named: exampleCardLabels[index])
        draggableView.delegate = self
        return draggableView
    }

}
