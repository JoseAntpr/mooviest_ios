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
        
        imageView = UIImageView()
        setupOverlay(namedImage:"clear_overlay",tinColor: .white, backgroundColor: UIColor.black)
        
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
            setupOverlay(namedImage:"clear_overlay",tinColor: .white, backgroundColor: UIColor.black.withAlphaComponent(0.7))
        } else if _mode == GGOverlayViewMode.ggOverlayViewModeRight {
            setupOverlay(namedImage:"star_overlay",tinColor: .white, backgroundColor: UIColor(netHex: favourite_color))
        } else if _mode == GGOverlayViewMode.ggOverlayViewModeTop {
            setupOverlay(namedImage:"bookmark_overlay",tinColor: .white, backgroundColor: UIColor(netHex: watchlist_color))
        } else {
            setupOverlay(namedImage:"eye_overlay",tinColor: .white, backgroundColor: UIColor(netHex: seen_color))
        }
    }
    
    func setupOverlay(namedImage:String,tinColor:UIColor, backgroundColor: UIColor) {
        imageView.image = UIImage(named: namedImage)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tinColor
        imageView.backgroundColor = backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
