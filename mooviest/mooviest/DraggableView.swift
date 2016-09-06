//
//  DraggableView.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//


import Foundation
import UIKit

let ACTION_MARGIN: Float = 120      //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
let SCALE_STRENGTH: Float = 4       //%%% how quickly the card shrinks. Higher = slower shrinking
let SCALE_MAX:Float = 0.93          //%%% upper bar for how much the card shrinks. Higher = shrinks less
let ROTATION_MAX: Float = 1         //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
let ROTATION_STRENGTH: Float = 320  //%%% strength of rotation. Higher = weaker rotation
let ROTATION_ANGLE: Float = 3.14/8  //%%% Higher = stronger rotation angle


protocol DraggableViewDelegate {
    func cardSwipedLeft(card: UIView) -> Void
    func cardSwipedRight(card: UIView) -> Void
    func cardSwipedTop(card: UIView) -> Void
    func cardSwipedBottom(card: UIView) -> Void
}

class DraggableView: UIView {
    var delegate: DraggableViewDelegate!
    var panGestureRecognizer: UIPanGestureRecognizer!
    var originPoint: CGPoint!
    var overlayView: OverlayView!
    var imageView: UIImageView!
    var noImageLabel: UILabel!
    
    var xFromCenter: Float!
    var yFromCenter: Float!
    var index:Int!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, index: Int) {
        super.init(frame: frame)
        self.index = index
        print(index)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableView.beingDragged(_:)))
        addGestureRecognizer(panGestureRecognizer)
        setupComponents()
        setupConstraints()
    }
    
    func getIndex()-> Int{
        return index
    }
    
    func setupComponents() {
        xFromCenter = 0
        yFromCenter = 0
        
        backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        noImageLabel = UILabel()
        noImageLabel.text = "Image No Found"
        noImageLabel.textColor = UIColor.whiteColor()
        noImageLabel.textAlignment = NSTextAlignment.Center
        noImageLabel.font = noImageLabel.font.fontWithSize(30)
        
        imageView = UIImageView(image: UIImage(named: "clock"))
        imageView.contentMode = UIViewContentMode.ScaleToFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        
        overlayView = OverlayView()
        overlayView.alpha = 0
        addSubview(noImageLabel)
        addSubview(imageView)
        addSubview(overlayView)
        
    }
    
    func setupConstraints() {
        noImageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(imageView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(imageView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(imageView.rightAnchor.constraintEqualToAnchor(rightAnchor))
        addConstraint(imageView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))
        
        addConstraint(overlayView.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(overlayView.centerYAnchor.constraintEqualToAnchor(centerYAnchor))
        addConstraint(overlayView.widthAnchor.constraintEqualToConstant(150))
        addConstraint(overlayView.heightAnchor.constraintEqualToConstant(150))
        
        addConstraint(noImageLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        addConstraint(noImageLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor))
        addConstraint(noImageLabel.widthAnchor.constraintEqualToAnchor(widthAnchor))
        addConstraint(noImageLabel.heightAnchor.constraintEqualToConstant(100))

    }
    
    func beingDragged(gestureRecognizer: UIPanGestureRecognizer) -> Void {
        xFromCenter = Float(gestureRecognizer.translationInView(self).x)
        yFromCenter = Float(gestureRecognizer.translationInView(self).y)
        
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            self.originPoint = self.center
            print(self.center)
            break
        case UIGestureRecognizerState.Changed:
            let rotationStrength: Float = min(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX)
            let rotationAngle = ROTATION_ANGLE * rotationStrength
            let scale = max(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX)
            
            self.center = CGPointMake(self.originPoint.x + CGFloat(xFromCenter), self.originPoint.y + CGFloat(yFromCenter))
            
            let transform = CGAffineTransformMakeRotation(CGFloat(rotationAngle))
            let scaleTransform = CGAffineTransformScale(transform, CGFloat(scale), CGFloat(scale))
            self.transform = scaleTransform
            self.updateOverlay(sinceXCenter: CGFloat(xFromCenter),sinceYCenter: CGFloat(yFromCenter))
            break
        case UIGestureRecognizerState.Ended:
            self.afterSwipeAction()
            break
        case UIGestureRecognizerState.Possible:
            break
        case UIGestureRecognizerState.Cancelled:
            break
        case UIGestureRecognizerState.Failed:
            break
        }
    }
    
    func updateOverlay(sinceXCenter x: CGFloat, sinceYCenter y: CGFloat) -> Void {
        var distance = CGFloat(0)
        if abs(x) >= abs(y) {
            distance = x
            if x > 0 {
                overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeRight)
            } else {
                overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
            }
        } else {
            distance = y
            if y > 0 {
                overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeBottom)
            } else {
                overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeTop)
            }
        }
        overlayView.alpha = CGFloat(min(fabsf(Float(distance))/100, 1))
    }
    
    func returnOriginalPosition() {
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.transform = CGAffineTransformMakeRotation(0)
            self.overlayView.alpha = 0
            self.center = self.originPoint
        })
    }
    
    func afterSwipeAction() -> Void {
        let floatXFromCenter = Float(xFromCenter)
        let floatYFromCenter = Float(yFromCenter)
    
        if abs(floatXFromCenter) >=  abs(floatYFromCenter) {
            if floatXFromCenter > ACTION_MARGIN {
                self.rightAction()
            } else if floatXFromCenter < -ACTION_MARGIN {
                self.leftAction()
            } else {
                returnOriginalPosition()
            }
        } else {
            if floatYFromCenter > ACTION_MARGIN {
                self.bottomAction()
            } else if floatYFromCenter < -ACTION_MARGIN {
                self.topAction()
            } else {
                returnOriginalPosition()
            }
        }
    }
    
    func rightAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(600, 2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(-300, 2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    self.transform = CGAffineTransformMakeRotation(-1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
    
    func topAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(2 * CGFloat(xFromCenter) + self.originPoint.x, -200)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    //self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedTop(self)
    }
    
    func bottomAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(2 * CGFloat(xFromCenter) + self.originPoint.x, 1000)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    //self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedBottom(self)
    }
    
    func rightClickAction() -> Void {
        let finishPoint = CGPointMake(600, self.center.y)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftClickAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(-200, self.center.y)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    self.transform = CGAffineTransformMakeRotation(-1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
    
    func topClickAction() -> Void {
        let finishPoint = CGPointMake(self.center.x, -200)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    //self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedTop(self)
    }
    
    func bottomClickAction() -> Void {
        let finishPoint = CGPointMake(self.center.x,1000)
        UIView.animateWithDuration(0.3,
                                   animations: {
                                    self.center = finishPoint
                                    //self.transform = CGAffineTransformMakeRotation(1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedBottom(self)
    }
}