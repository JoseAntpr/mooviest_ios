//
//  DraggableView.swift
//  Mooviest
//
//  Created by Antonio RG on 21/7/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//


import Foundation
import UIKit

let ACTION_MARGIN: Float = 120      //Distance from the center where the action is applied.
let SCALE_STRENGTH: Float = 4       //Scaling speed, if it is larger it will be slower
let SCALE_MAX:Float = 0.93          //If it is higher it shrinks less
let ROTATION_MAX: Float = 1         //max rotation
let ROTATION_STRENGTH: Float = 320  //rotation speed, if it is larger it will be slower
let ROTATION_ANGLE: Float = 3.14/8  //rotation angle

enum MoveDirection:Int {
    case right = 1
    case left = -1
    case top = -2
    case bottom = 2
}

class DraggableView: UIView {
    let porcentOverlay = CGFloat(0.4)
    var delegate: DraggableViewDelegate!
    var panGestureRecognizer: UIPanGestureRecognizer!
    var originPoint: CGPoint!
    var overlayView: OverlayView!
    var coverView:CoverView!
    
    var xFromCenter: Float!
    var yFromCenter: Float!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableView.beingDragged(_:)))
        addGestureRecognizer(panGestureRecognizer)
        setupComponents()
        setupConstraints()
    }
    
    func setupComponents() {
        xFromCenter = 0
        yFromCenter = 0
        
        self.backgroundColor = UIColor.white
        
        coverView = CoverView(porcentCaption: 0.12, porcentRating: 0.16)
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.9).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        coverView.titleLabel.lineBreakMode = .byWordWrapping
        coverView.titleLabel.numberOfLines = 2
        
        overlayView = OverlayView()
        overlayView.alpha = 0
        
        addSubview(coverView)
        addSubview(overlayView)        
    }
    
    func setupConstraints() {
        coverView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(coverView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(coverView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(coverView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(coverView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        addConstraint(overlayView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(overlayView.centerYAnchor.constraint(equalTo: centerYAnchor))
        addConstraint(overlayView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: porcentOverlay))
        addConstraint(overlayView.heightAnchor.constraint(equalTo: overlayView.widthAnchor))
    }
    
    func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) -> Void {
        xFromCenter = Float(gestureRecognizer.translation(in: self).x)
        yFromCenter = Float(gestureRecognizer.translation(in: self).y)
        
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.began:
            self.originPoint = self.center
            break
        case UIGestureRecognizerState.changed:
            let rotationStrength: Float = min(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX)
            let rotationAngle = ROTATION_ANGLE * rotationStrength
            var scale = max(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX)
            
            let rotationStrength2: Float = min(yFromCenter/ROTATION_STRENGTH, ROTATION_MAX)
            let scale2 = max(1 - fabsf(rotationStrength2) / SCALE_STRENGTH, SCALE_MAX)
            scale = min(scale, scale2)
            
            let translation = CGAffineTransform(translationX:  CGFloat(xFromCenter), y:  CGFloat(yFromCenter))
            let rotation = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
            let scaleTransform = rotation.concatenating(translation).scaledBy(x: CGFloat(scale), y: CGFloat(scale))
            
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
    
    func move(direction: MoveDirection) {
        overlayView.alpha = 0
        var transform:CGAffineTransform!
        let rotationStrength: Float = min(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX)
        let rotationAngle = ROTATION_ANGLE * rotationStrength
        switch direction {
            case .left ,
                 .right:
                let translation = CGAffineTransform(translationX: self.frame.width*2*CGFloat(direction.rawValue), y: CGFloat(yFromCenter))
                let rotation = CGAffineTransform(rotationAngle: CGFloat(1 - abs(rotationAngle))*CGFloat(direction.rawValue))
                transform = rotation.concatenating(translation).scaledBy(x: CGFloat(SCALE_MAX), y: CGFloat(SCALE_MAX))
            case .top ,
                 .bottom:
                let y = yFromCenter < ACTION_MARGIN ? CGFloat(direction.rawValue) * CGFloat(self.frame.height) : CGFloat(yFromCenter*3.3)
                let translation = CGAffineTransform(translationX: CGFloat(xFromCenter), y: y)
                let rotation = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
                transform = rotation.concatenating(translation).scaledBy(x: CGFloat(SCALE_MAX), y: CGFloat(SCALE_MAX))
        }
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.transform = transform
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
    }
    
    func rightAction() -> Void {
        move(direction: .right)
        delegate.cardSwipedRight(self)
    }
    
    func leftAction() -> Void {
        move(direction: .left)
        delegate.cardSwipedLeft(self)
    }
    
    func topAction() -> Void {
        move(direction: .top)
        delegate.cardSwipedTop(self)
    }
    
    func bottomAction() -> Void {
        move(direction: .bottom)
        delegate.cardSwipedBottom(self)
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
}
