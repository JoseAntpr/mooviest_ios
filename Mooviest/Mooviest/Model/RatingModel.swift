//
//  RatingModel.swift
//  Mooviest
//
//  Created by Antonio RG on 30/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

struct Rating: Model {
    var name: String
    var rating:Int
    var count: Int
    var dateUpdate: String
}