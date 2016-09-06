//
//  OverlayView.swift
//  Mooviest
//
//  Created by Antonio RG on 3/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation
import UIKit

enum GGOverlayViewMode {
    case GGOverlayViewModeLeft
    case GGOverlayViewModeRight
    case GGOverlayViewModeTop
    case GGOverlayViewModeBottom
}

class OverlayView: UIView{
    var _mode: GGOverlayViewMode = GGOverlayViewMode.GGOverlayViewModeLeft
    var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        imageView = UIImageView(image: UIImage(named: "closes"))
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(imageView.leftAnchor.constraintEqualToAnchor(leftAnchor))
        addConstraint(imageView.rightAnchor.constraintEqualToAnchor(rightAnchor))
        addConstraint(imageView.topAnchor.constraintEqualToAnchor(topAnchor))
        addConstraint(imageView.bottomAnchor.constraintEqualToAnchor(bottomAnchor))
    }
    
    func setMode(mode: GGOverlayViewMode) -> Void {
        if _mode == mode {
            return
        }
        _mode = mode
        
        if _mode == GGOverlayViewMode.GGOverlayViewModeLeft {
            imageView.image = UIImage(named: "closes")
        } else if _mode == GGOverlayViewMode.GGOverlayViewModeRight {
            imageView.image = UIImage(named: "heart")
        } else if _mode == GGOverlayViewMode.GGOverlayViewModeTop {
            imageView.image = UIImage(named: "clock")
        } else {
            imageView.image = UIImage(named: "eye")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}