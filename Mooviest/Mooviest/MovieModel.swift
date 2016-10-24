//
//  MovieModel.swift
//  Mooviest
//
//  Created by Antonio RG on 30/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

enum TypeMovie:String {
    case seen = "seen"
    case watchlist = "watchlist"
    case favourite = "favourite"
    case swipe = "swipe"
    case black = "black"
}

struct Movie: Model {
    var id: Int
    var idMovieLang: Int
    var idCollection: Int //-1 para cuado no esté asignada
    var typeMovie:String
    
    var title: String
    var originalTitle: String
    var image: String
    var backdrop: String
    var synopsis: String
    var average: Float
    var runtime: Int
    var released: Int
    var producers: String
    var country: String
    
    var genres: [String]
    var participations: [Participation]
    var ratings: [Rating]
}
