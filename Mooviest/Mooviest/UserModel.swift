//
//  UserModel.swift
//  Mooviest
//
//  Created by Antonio RG on 17/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

struct User:Model {
    var id: Int
    var username:String
    var email:String
    var firstname:String
    var lastname:String
    var avatar: String
    var codeLang: String
    var gender: String
    var postalCode: String
    var city: String
    var born: String
}
