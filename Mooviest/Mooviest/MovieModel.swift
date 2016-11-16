//
//  MovieModel.swift
//  Mooviest
//
//  Created by Antonio RG on 30/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import UIKit


struct TypeMovieModel {
    let rawValue:String
    let hashValue: Int
    let image:String
    let color: UIColor
    let title: String 
}
//traduccion title
struct TypeMovieStruct{
    let seen = TypeMovieModel(rawValue: "seen", hashValue: 1, image: "eye", color: seen_color, title: "Vistas")
    let watchlist = TypeMovieModel(rawValue: "watchlist", hashValue: 2, image: "bookmark", color: watchlist_color,title: "Pendientes")
    let favourite = TypeMovieModel(rawValue: "favourite", hashValue: 3, image: "star", color: favourite_color, title: "Favoritas")
    let black = TypeMovieModel(rawValue: "black", hashValue: 5, image: "clear", color: blacklist_color,title: "Lista negra")
}

let TypeMovie = TypeMovieStruct()

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
