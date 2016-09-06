//
//  RatingParser.swift
//  Mooviest
//
//  Created by Antonio RG on 31/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation
import SwiftyJSON

class RatingParser: NSObject, Parser {
    static func jsonToRating(Rating r: JSON)throws -> Rating {
        guard let name = r["name"].string, let rating = r["rating"].int,
            let count = r["count"].int, let dateUpdate = r["date_update"].string
            else {
                throw Error.InvalidRating
        }
        return Rating(name: name, rating: rating, count: count, dateUpdate: dateUpdate)
    }
}