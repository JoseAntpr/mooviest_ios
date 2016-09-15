//
//  ParticipationParser.swift
//  Mooviest
//
//  Created by Antonio RG on 31/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation


class ParticipationParser: NSObject, Parser {
    static func jsonToParticipation(Participation p: [String:Any])throws -> Participation {
        guard let id = (p["celebrity"] as! [String:Any])["id"] as? Int, let name = (p["celebrity"] as! [String:Any])["name"] as? String,
            let role = p["role"] as? Int, let character = p["character"] as? String == nil ? "":p["character"] as? String,
            let award = p["award"] as? String
            else {
                throw ErrorMovie.invalidParticipation
        }
        return Participation(id: id, name: name, role: role, character: character, award: award)
    }
}
