//
//  Message.swift
//  Mooviest
//
//  Created by Antonio RG on 19/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit

class Message {
    static func msgPopupDelay(title t: String, message m:String, delay s: Double, ctrl: UIViewController, okTapped: @escaping ()->Void) {
        
        let alertController = UIAlertController(title: t, message: m, preferredStyle: .alert)
        if s > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + s) {
                alertController.dismiss(animated: true, completion: nil)
                okTapped()
            }
        } else {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                okTapped()
            }))
        }
        ctrl.present(alertController, animated: true, completion: nil)
    }
}
