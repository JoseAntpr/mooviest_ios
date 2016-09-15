//
//  RatingParser.swift
//  Mooviest
//
//  Created by Antonio RG on 31/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation


class RatingParser: NSObject, Parser {
    static func jsonToRating(Rating r: [String:Any])throws -> Rating {
        guard let name = r["name"] as? String, let rating = r["rating"] as? Int,
            let count = r["count"] as? Int, let dateUpdate = r["date_update"] as? String
            else {
                throw ErrorMovie.invalidRating
        }
        return Rating(name: name, rating: rating, count: count, dateUpdate: dateUpdate)
    }
}
