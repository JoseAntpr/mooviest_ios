//
//  MovieParser.swift
//  Mooviest
//
//  Created by Antonio RG on 30/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

extension Movie {
    init(json:[String:Any])throws {
        
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
        //Extract original title
        guard let originalTitle = json["original_title"] as? String else{
            throw SerializationError.missing("original title")
        }
        //Extract image
        guard var image = json["image"] as? String else{
            throw SerializationError.missing("image")
        }
        //Extract backdrop
        guard let backdrop = json["backdrop"] as? String else{
            throw SerializationError.missing("backdrop")
        }
        //Extract synopsis
        guard let synopsis = json["synopsis"] as? String else{
            throw SerializationError.missing("synopsis")
        }
        //Extract average
        guard let average = json["average"] as? Float else{
            throw SerializationError.missing("average")
        }
        //Extract runtime
        guard let runtime = json["runtime"] as? Int else{
            throw SerializationError.missing("runtime")
        }
        //Extract released
        guard let released = json["released"] as? Int else{
            throw SerializationError.missing("released")
        }
        //Extract producers
        guard let producers = json["movie_producer"] as? String else{
            throw SerializationError.missing("producers")
        }
        var country = ""
        //Extract country
        if let c = json["country"] as? String {
            country = c
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
        
        //Extract genres
        guard let genresJson = json["genres"] as? [[String:Any]] else{
            throw SerializationError.missing("genres")
        }
        //Extract participations
        guard let participationsJson = json["participations"] as? [[String:Any]] else{
            throw SerializationError.missing("participations")
        }
        //Extract ratings
        guard let ratingsJson = json["ratings"] as? [[String:Any]] else{
            throw SerializationError.missing("ratings")
        }
        
        var genres = [String]()
        for genre in genresJson {
            guard let name = genre["name"] as? String
                else {continue}
            genres.append(name)
        }
        
        var participations = [Participation]()
        for p in participationsJson {
            let participation:Participation?
           // do {
                participation = try! Participation(json: p)
                participations.append(participation!)
//            } catch is SerializationError {
//                participation = nil
//            }
        }
        
        var ratings = [Rating]()
        for r in ratingsJson {
            let rating:Rating?
            do {
                rating = try Rating(json: r)
                ratings.append(rating!)
            } catch is SerializationError {
                rating = nil
            }
        }
        
        //completar imagenes segun url
        if image.lowercased().range(of: "http://") == nil &&
            image.lowercased().range(of: "https://") == nil {
            image =  "https://img.tviso.com/ES/poster/w430/"+image
        }
        
        self.id = id
        self.idMovieLang = idMovieLang
        self.idCollection = idCollection
        self.typeMovie = typeMovie
        
        self.image = image
        self.backdrop = backdrop
        self.title = title
        self.originalTitle = originalTitle
        self.average = average
        self.synopsis = synopsis
        self.runtime = runtime
        self.released = released
        self.producers = producers
        self.country = country
        
        self.genres = genres
        self.participations = participations
        self.ratings = ratings
    }
}
