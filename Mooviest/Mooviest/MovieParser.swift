//
//  MovieParser.swift
//  Mooviest
//
//  Created by Antonio RG on 30/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation


class MovieParser: NSObject, Parser {
    static func jsonToMovie(Movie m: [String:Any])throws -> Movie {
        print(m)
        guard let id = m["id"] as? Int,let originalTitle = m["original_title"] as? String,
            let average = m["average"] as? String, let runtime = m["runtime"] as? Int,
            let released = m["released"] as? Int, let producers = m["movie_producer"] as? String,
        let sagaOrder = m["saga_order"] as? Int,let genresJson = m["genres"] as? [[String:Any]],
        let backdrop = m["backdrop"] as? String ,let participationsJson = m["participations"] as? [[String:Any]], let ratingsJson = m["ratings"] as? [[String:Any]],
        let langs = m["langs"] as? [[String:Any]]
            else {
                throw ErrorMovie.invalidMovie
        }
        
        guard var image = langs[0]["image"] as? String,let title = langs[0]["title"] as? String,
            let synopsis = langs[0]["synopsis"] as? String, let trailer = langs[0]["trailer"] as? String == nil ? "":langs[0]["trailer"] as? String,
        let country = (langs[0]["country"] as! [String:String])["name"], let countryCode = (langs[0]["country"] as! [String:String])["code"]
            else {
                throw ErrorMovie.invalidMovie
        }
        
        var genres = [String]()
        for genre in genresJson {
            guard let name = (genre["langs"] as! [[String:String]])[0]["name"]
                else {continue}
            genres.append(name)
        }
        
        var participations = [Participation]()
        for p in participationsJson {
            let participation:Participation?
            do {
                participation = try ParticipationParser.jsonToParticipation(Participation: p)
                participations.append(participation!)
            } catch ErrorMovie.invalidParticipation {
                participation = nil
            }
        }
        
        var ratings = [Rating]()
        for r in ratingsJson {
            
            let rating:Rating?
            do {
                rating = try RatingParser.jsonToRating(Rating: r)
                ratings.append(rating!)
            } catch ErrorMovie.invalidRating {
                rating = nil
            }
            
        }
        
        if image.lowercased().range(of: "http://") == nil &&
            image.lowercased().range(of: "https://") == nil {
            image =  "https://img.tviso.com/ES/poster/w430/"+image
        }
        return Movie(id: id, image: image, backdrop: backdrop, originalTitle: originalTitle, average: average, title: title, synopsis: synopsis, runtime: runtime, released: released, producers: producers, trailer: trailer, country: country, countryCode: countryCode, sagaOrder: sagaOrder, genres: genres, participations: participations, ratings: ratings)
    }
}
