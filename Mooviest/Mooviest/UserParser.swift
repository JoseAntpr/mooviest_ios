//
//  UserParser.swift
//  Mooviest
//
//  Created by Antonio RG on 17/9/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

extension User {
    init(json:[String:Any]) throws {
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
        //Extract firstname
        guard let firstname = userJson["first_name"] as? String else {
            throw SerializationError.missing("firstname")
        }
        //Extract lastname
        guard let lastname = userJson["last_name"] as? String else {
            throw SerializationError.missing("lastname")
        }
        //Extract profile
        guard let profileJson = userJson["profile"] as? [String:Any] else {
            throw SerializationError.missing("profile")
        }
        //Extract avatar
        guard let avatar = profileJson["avatar"] as? String else {
            throw SerializationError.missing("avatar")
        }
        //Extract code lang
        guard let langJson = profileJson["lang"] as? [String:Any],
            let codeLang = langJson["code"] as? String else {
            throw SerializationError.missing("langCode")
        }
        //Extract gender
        var gender = ""
        if let genderString = profileJson["gender"] as? String {
            gender = genderString
        }
        //Extract born
        var born = ""
        born.toString(string: profileJson["born"] as Any)
        //Extract postal code
        var postalCode = ""
        if let postalCodeString = profileJson["postalCode"] as? String {
            postalCode = postalCodeString
        }
        //Extract city
        var city = ""
        if let cityString = profileJson["city"] as? String {
            city = cityString
        }

        
        // Initialize properties
        self.id = id
        self.username = username
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.avatar = avatar
        self.gender = gender
        self.born = born
        self.postalCode = postalCode
        self.city = city
        self.codeLang = codeLang
    }
    
    func getJson()->[String:Any] {
        let json:[String:Any] =  [
                "id": id,
                "username": username,
                "email": email,
                "first_name": firstname,
                "last_name": lastname,
                "profile": [
//                    "avatar": avatar,
                    "gender": gender,
                    "born": born,
                    "postalCode": postalCode,
                    "city": city,
                    "lang": [
                        "code": codeLang
                    ]
            ]
        ]
        return json
    }
}
