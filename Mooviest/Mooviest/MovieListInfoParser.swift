//
//  MovieListInfoParser.swift
//  Mooviest
//
//  Created by Antonio RG on 21/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

extension MovieListInfo {
    init(json:[String:Any], isSwwipe: Bool) throws {
        let externalImagePath = "https://cdn.tviso.com/"
        var tvisoImagePath = "https://img.tviso.com/ES/poster/w200/"
        if isSwwipe {
            tvisoImagePath = "https://img.tviso.com/ES/poster/w430/"
        }
        let pre = "EXTERNAL#"
        //Extract id
        guard let id = json["id"] as? Int else{
            throw SerializationError.missing("id")
        }
        //Extract id movie lang
        guard let idMovieLang = json["movie_lang_id"] as? Int else{
            throw SerializationError.missing("idMovieLang")
        }
        //Extract title
        guard let title = json["title"] as? String else{
            throw SerializationError.missing("title")
        }
        //Extract image
        var image = ""
        image.toString(string: json["image"])
        
        //Extract average
        guard let average = json["average"] as? Float else{
            throw SerializationError.missing("average")
        }
        //Extract collection (que devuelve cuando no esté en ninguna lista)
        var collection:[String:Any] = [
            "id": -1,
            "typeMovie": ""
        ]
        if let co = json["collection"] as? [String:Any] {
            collection = co
        }
        //Extract idCollection
        guard let idCollection = collection["id"] as? Int else{
            throw SerializationError.missing("idCollection")
        }
        //Extract typeMovie
        guard let typeMovie = collection["typeMovie"] as? String else{
            throw SerializationError.missing("typeMovie")
        }
        if image != "" {
            
            if image.hasPrefix(pre) {
                image = externalImagePath + image.substring(from: pre.endIndex) + ".jpg"
            } else if !image.hasPrefix("http://") &&
                !image.hasPrefix("https://"){
                image =  tvisoImagePath+image
            }
        }
        
        // Initialize properties
        self.id = id
        self.idMovieLang = idMovieLang
        self.idCollection = idCollection
        self.title = title
        self.image = image
        self.average = average
        self.typeMovie = typeMovie
    }
}
