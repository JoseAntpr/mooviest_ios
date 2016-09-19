//
//  UserParser.swift
//  Mooviest
//
//  Created by Antonio RG on 17/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

extension User {
    init(json:[String:Any]) throws {
        //Extract id
        guard let token = json["token"] as? String else{
            throw SerializationError.missing("token")
        }
        //Extract user
        guard let userJson = json["user"] as? [String:Any] else {
            throw SerializationError.missing("user")
        }
        //Extract id user
        guard let id = userJson["id"] as? Int else{
            throw SerializationError.missing("id")
        }
        //Extract username
        guard let username = userJson["username"] as? String else {
            throw SerializationError.missing("username")
        }
        //Extract email
        guard let email = userJson["email"] as? String else {
            throw SerializationError.missing("email")
        }
        //Extract id profile
        guard let profileJson = userJson["profile"] as? [String:Any] else {
            throw SerializationError.missing("profile")
        }
        //Extract id avatar
        guard let avatar = profileJson["avatar"] as? String else {
            throw SerializationError.missing("avatar")
        }
        //Extract id avatar
        guard let langJson = profileJson["lang"] as? [String:Any],
            let langCode = langJson["code"] as? String else {
            throw SerializationError.missing("langCode")
        }
        
        // Initialize properties
        self.id = id
        self.username = username
        self.email = email
        self.token = token
        self.langCode = langCode
        self.avatar = avatar
    }
}
