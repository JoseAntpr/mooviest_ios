//
//  RatingParser.swift
//  Mooviest
//
//  Created by Antonio RG on 31/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation


extension  Rating {    
    init(json:[String:Any]) throws {
        //Extract name
        guard let name = json["name"] as? String else{
            throw SerializationError.missing("name")
        }
        //Extract rating
        guard let rating = json["rating"] as? Int else{
            throw SerializationError.missing("rating")
        }
        //Extract count
        guard let count = json["count"] as? Int else{
            throw SerializationError.missing("count")
        }
        //Extract date update
        guard let dateUpdate = json["date_update"] as? String else{
            throw SerializationError.missing("dateUpdate")
        }
        
        self.name = name
        self.rating = rating
        self.count = count
        self.dateUpdate = dateUpdate
    }
}
