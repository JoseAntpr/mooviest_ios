//
//  AuthenticationParser.swift
//  Mooviest
//
//  Created by Antonio RG on 19/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

extension Authentication {
    init(json:[String:Any]) throws {
        //Extract token
        guard let token = json["token"] as? String else{
            throw SerializationError.missing("token")
        }
        //Extract user
        guard let userJson = json["user"] as? [String:Any] else {
            throw SerializationError.missing("user")
        }
        //Extract id user
        guard let idUser = userJson["id"] as? Int else{
            throw SerializationError.missing("id")
        }
        
        // Initialize properties
        self.idUser = idUser
        self.token = token
    }
}
