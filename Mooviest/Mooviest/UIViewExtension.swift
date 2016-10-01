//
//  UIViewExtension.swift
//  Mooviest
//
//  Created by Antonio RG on 21/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

extension UIView {
    func transition(withDuration: TimeInterval, to:UIView) {
        UIView.animate(withDuration: withDuration/2, animations: {
            self.alpha = 0.0
            }, completion: { (value) in
                UIView.animate(withDuration: withDuration/2) {
                    to.alpha = 0.7
                }
            }
        )
    }
    
    func comeBackOrigin(withDuration: TimeInterval , moved: CGFloat) {
        UIView.animate(withDuration: withDuration) {
            self.frame.origin.y -= moved
        }
    }
}

