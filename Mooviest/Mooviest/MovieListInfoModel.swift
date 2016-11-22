//
//  MovieListInfoModel.swift
//  Mooviest
//
//  Created by Antonio RG on 21/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

struct MovieListInfo: Model {
    var id: Int
    var idMovieLang: Int
    var title: String
    var image: String
    var backdrop: String
    var average: Float
    var idCollection: Int //-1 if nil
    var typeMovie:String
}
