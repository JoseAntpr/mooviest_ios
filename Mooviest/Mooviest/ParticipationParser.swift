//
//  ParticipationParser.swift
//  Mooviest
//
//  Created by Antonio RG on 31/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

extension Participation {
    init(json:[String:Any]) throws {
        //Extract celebrity
        guard let celebrity = json["celebrity"] as? [String:Any] else{
            throw SerializationError.missing("celebrity")
        }
        //Extract id
        guard let id = celebrity["id"] as? Int else{
            throw SerializationError.missing("id")
        }
        //Extract name
        guard let name = celebrity["name"] as? String else{
            throw SerializationError.missing("name")
        }        
        //Extract born
        var born = ""
        if let b = json["born"] as? String {
            born = b
        }
        //Extract image
        guard var image = celebrity["image"] as? String else{
            throw SerializationError.missing("image")
        }
        //Extract twitter
        guard let twitter = celebrity["twitter_account"] as? String else{
            throw SerializationError.missing("twitter")
        }
        //Extract address
        guard let address = celebrity["address"] as? String else{
            throw SerializationError.missing("address")
        }
        //Extract role
        guard let role = json["role"] as? String else{
            throw SerializationError.missing("role")
        }
        //Extract character
        guard let character = json["character"] as? String else{
            throw SerializationError.missing("character")
        }
        //Extract name
        guard let award = json["award"] as? String else{
            throw SerializationError.missing("award")
        }
        
        image = "https://img.tviso.com/XX/face/w175"+image

        self.id = id
        self.name = name
        self.born = born
        self.image = image
        self.twitter = twitter
        self.address = address
        self.role = role
        self.character = character
        self.award = award
    }
}
