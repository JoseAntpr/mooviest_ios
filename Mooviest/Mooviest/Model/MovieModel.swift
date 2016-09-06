//
//  MovieModel.swift
//  Mooviest
//
//  Created by Antonio RG on 30/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation



struct Movie: Model {
    var id: Int
    var image: String
    var originalTitle: String
    var average: String
    var title: String
    var synopsis: String
    var runtime: Int
    var released: Int
    var producers: String
    var trailer: String
    var country: String
    var countryCode: String
    var sagaOrder: Int
    var genres: [String]
    var participantes: [Participation]
    var ratings: [Rating]
    //emotions
}