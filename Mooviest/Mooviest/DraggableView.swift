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
    func cardSwipedLeft(_ card: UIView) -> Void
    func cardSwipedRight(_ card: UIView) -> Void
    func cardSwipedTop(_ card: UIView) -> Void
    func cardSwipedBottom(_ card: UIView) -> Void
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
        
        backgroundColor = UIColor.white.withAlphaComponent(0)
        noImageLabel = UILabel()
        noImageLabel.text = "Image No Found"
        noImageLabel.textColor = UIColor.white
        noImageLabel.textAlignment = NSTextAlignment.center
        noImageLabel.font = noImageLabel.font.withSize(30)
        
        imageView = UIImageView(image: UIImage(named: "clock"))
        imageView.contentMode = UIViewContentMode.scaleToFill
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
        
        addConstraint(imageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(imageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(imageView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(imageView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        addConstraint(overlayView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(overlayView.centerYAnchor.constraint(equalTo: centerYAnchor))
        addConstraint(overlayView.widthAnchor.constraint(equalToConstant: 150))
        addConstraint(overlayView.heightAnchor.constraint(equalToConstant: 150))
        
        addConstraint(noImageLabel.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(noImageLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        addConstraint(noImageLabel.widthAnchor.constraint(equalTo: widthAnchor))
        addConstraint(noImageLabel.heightAnchor.constraint(equalToConstant: 100))
        
    }
    
    func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) -> Void {
        xFromCenter = Float(gestureRecognizer.translation(in: self).x)
        yFromCenter = Float(gestureRecognizer.translation(in: self).y)
        
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.began:
            self.originPoint = self.center
            print(self.center)
            break
        case UIGestureRecognizerState.changed:
            let rotationStrength: Float = min(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX)
            let rotationAngle = ROTATION_ANGLE * rotationStrength
            let scale = max(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX)
            
            self.center = CGPoint(x: self.originPoint.x + CGFloat(xFromCenter), y: self.originPoint.y + CGFloat(yFromCenter))
            
            let transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
            let scaleTransform = transform.scaledBy(x: CGFloat(scale), y: CGFloat(scale))
            self.transform = scaleTransform
            self.updateOverlay(sinceXCenter: CGFloat(xFromCenter),sinceYCenter: CGFloat(yFromCenter))
            break
        case UIGestureRecognizerState.ended:
            self.afterSwipeAction()
            break
        case UIGestureRecognizerState.possible:
            break
        case UIGestureRecognizerState.cancelled:
            break
        case UIGestureRecognizerState.failed:
            break
        }
    }
    
    func updateOverlay(sinceXCenter x: CGFloat, sinceYCenter y: CGFloat) -> Void {
        var distance = CGFloat(0)
        if abs(x) >= abs(y) {
            distance = x
            if x > 0 {
                overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeRight)
            } else {
                overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeLeft)
            }
        } else {
            distance = y
            if y > 0 {
                overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeBottom)
            } else {
                overlayView.setMode(GGOverlayViewMode.ggOverlayViewModeTop)
            }
        }
        overlayView.alpha = CGFloat(min(fabsf(Float(distance))/100, 1))
    }
    
    func returnOriginalPosition() {
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.transform = CGAffineTransform(rotationAngle: 0)
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
        let finishPoint: CGPoint = CGPoint(x: 600, y: 2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.center = finishPoint
                        self.transform = CGAffineTransform(rotationAngle: 1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftAction() -> Void {
        let finishPoint: CGPoint = CGPoint(x: -300, y: 2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.center = finishPoint
                        self.transform = CGAffineTransform(rotationAngle: -1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
    
    func topAction() -> Void {
        let finishPoint: CGPoint = CGPoint(x: 2 * CGFloat(xFromCenter) + self.originPoint.x, y: -200)
        UIView.animate(withDuration: 0.3,
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
        let finishPoint: CGPoint = CGPoint(x: 2 * CGFloat(xFromCenter) + self.originPoint.x, y: 1000)
        UIView.animate(withDuration: 0.3,
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
        let finishPoint = CGPoint(x: 600, y: self.center.y)
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.center = finishPoint
                        self.transform = CGAffineTransform(rotationAngle: 1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftClickAction() -> Void {
        let finishPoint: CGPoint = CGPoint(x: -200, y: self.center.y)
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.center = finishPoint
                        self.transform = CGAffineTransform(rotationAngle: -1)
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
    
    func topClickAction() -> Void {
        let finishPoint = CGPoint(x: self.center.x, y: -200)
        UIView.animate(withDuration: 0.3,
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
        let finishPoint = CGPoint(x: self.center.x,y: 1000)
        UIView.animate(withDuration: 0.3,
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
