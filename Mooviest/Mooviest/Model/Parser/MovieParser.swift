//
//  MovieParser.swift
//  Mooviest
//
//  Created by Antonio RG on 30/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieParser: NSObject, Parser {
    static func jsonToMovie(Movie m: JSON)throws -> Movie {
        
        guard let id = m["id"].int,let originalTitle = m["original_title"].string,
            let average = m["average"].string, let runtime = m["runtime"].int,
            let released = m["released"].int, let producers = m["movie_producer"].string,
            let sagaOrder = m["saga_order"].int,let genresJson = m["genres"].array,
            let backdrop = m["backdrop"].string ,let participationsJson = m["participations"].array, let ratingsJson = m["ratings"].array,
            let langs = m["langs"].array
            else {
                throw Error.InvalidMovie
        }
        
        guard var image = langs[0]["image"].string,let title = langs[0]["title"].string,
            let synopsis = langs[0]["synopsis"].string, let trailer = langs[0]["trailer"].string == nil ? "":langs[0]["trailer"].string,
            let country = langs[0]["country"]["name"].string, let countryCode = langs[0]["country"]["code"].string
            else {
                throw Error.InvalidMovie
        }
        
        var genres = [String]()
        for genre in genresJson {
            guard let name = genre["langs"][0]["name"].string
            else {continue}
            genres.append(name)
        }
        
        var participations = [Participation]()
        for p in participationsJson {
            let participation = try! ParticipationParser.jsonToParticipation(Participation: p)
            participations.append(participation)
        }
        
        var ratings = [Rating]()
        for r in ratingsJson {
            let rating = try! RatingParser.jsonToRating(Rating: r)
            ratings.append(rating)
        }
       
        if image.lowercaseString.rangeOfString("http://") == nil &&
            image.lowercaseString.rangeOfString("https://") == nil {
            image =  "https://img.tviso.com/ES/poster/w430/"+image
        }
        return Movie(id: id, image: image, backdrop: backdrop, originalTitle: originalTitle, average: average, title: title, synopsis: synopsis, runtime: runtime, released: released, producers: producers, trailer: trailer, country: country, countryCode: countryCode, sagaOrder: sagaOrder, genres: genres, participantes: participations, ratings: ratings)
    }
}