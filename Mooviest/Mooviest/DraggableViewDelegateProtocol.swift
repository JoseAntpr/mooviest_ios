//
//  DraggableViewDelegateProtocol.swift
//  Mooviest
//
//  Created by Antonio RG on 1/11/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

protocol DraggableViewDelegate {
    func cardSwipedLeft(_ card: UIView) -> Void
    func cardSwipedRight(_ card: UIView) -> Void
    func cardSwipedTop(_ card: UIView) -> Void
    func cardSwipedBottom(_ card: UIView) -> Void
}
