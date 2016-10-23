//
//  MovieListInfoParser.swift
//  Mooviest
//
//  Created by Antonio RG on 21/10/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

extension MovieListInfo {
    init(json:[String:Any]) throws {
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
        guard var image = json["image"] as? String else{
            throw SerializationError.missing("image")
        }
        //Extract average
        guard let average = json["average"] as? Float else{
            throw SerializationError.missing("average")
        }
        //Extract collection (que devuelve cuando no esté en ninguna lista)
        guard let collection = json["collection"] as? [String:Any] else{
            throw SerializationError.missing("collection")
        }
        //Extract idCollection
        guard let idCollection = collection["id"] as? Int else{
            throw SerializationError.missing("idCollection")
        }
        //Extract typeMovie
        guard let typeMovie = collection["typeMovie"] as? String else{
            throw SerializationError.missing("typeMovie")
        }
        if image.lowercased().range(of: "http://") == nil &&
            image.lowercased().range(of: "https://") == nil {
            image = "https://img.tviso.com/ES/poster/w430/"+image
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
