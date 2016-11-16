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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        setupOverlay(namedImage:"bookmark_overlay",tinColor: .white, backgroundColor: watchlist_color)
        
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(imageView.centerXAnchor.constraint(equalTo: centerXAnchor))
        addConstraint(imageView.centerYAnchor.constraint(equalTo: centerYAnchor))
        addConstraint(imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6))
        addConstraint(imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor))
    }
    
    func setMode(_ mode: GGOverlayViewMode) -> Void {
        if _mode == mode {
            return
        }
        _mode = mode
        
        if _mode == GGOverlayViewMode.ggOverlayViewModeLeft {
            setupOverlay(namedImage:"bookmark_overlay",tinColor: .white, backgroundColor: watchlist_color)
            
        } else if _mode == GGOverlayViewMode.ggOverlayViewModeRight {
            setupOverlay(namedImage:"eye_overlay",tinColor: .white, backgroundColor: seen_color)
            
        } else if _mode == GGOverlayViewMode.ggOverlayViewModeTop {
            setupOverlay(namedImage:"star_overlay",tinColor: .white, backgroundColor: favourite_color)
        } else {
            setupOverlay(namedImage:"clear_overlay",tinColor: .white, backgroundColor: blacklist_color)
            
        }
    }
    
    func setupOverlay(namedImage:String,tinColor:UIColor, backgroundColor: UIColor) {
        imageView.image = UIImage(named: namedImage)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tinColor
        self.backgroundColor = backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
