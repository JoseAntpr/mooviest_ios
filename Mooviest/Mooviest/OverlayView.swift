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
    case ggOverlayViewModeLeft
    case ggOverlayViewModeRight
    case ggOverlayViewModeTop
    case ggOverlayViewModeBottom
}

class OverlayView: UIView{
    var _mode: GGOverlayViewMode = GGOverlayViewMode.ggOverlayViewModeLeft
    var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        imageView = UIImageView(image: UIImage(named: "closes"))
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(imageView.leftAnchor.constraint(equalTo: leftAnchor))
        addConstraint(imageView.rightAnchor.constraint(equalTo: rightAnchor))
        addConstraint(imageView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(imageView.bottomAnchor.constraint(equalTo: bottomAnchor))
    }
    
    func setMode(_ mode: GGOverlayViewMode) -> Void {
        if _mode == mode {
            return
        }
        _mode = mode
        
        if _mode == GGOverlayViewMode.ggOverlayViewModeLeft {
            imageView.image = UIImage(named: "closes")
        } else if _mode == GGOverlayViewMode.ggOverlayViewModeRight {
            imageView.image = UIImage(named: "heart")
        } else if _mode == GGOverlayViewMode.ggOverlayViewModeTop {
            imageView.image = UIImage(named: "clock")
        } else {
            imageView.image = UIImage(named: "eye")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
