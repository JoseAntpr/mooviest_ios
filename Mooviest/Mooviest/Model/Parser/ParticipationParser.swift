//
//  ParticipationParser.swift
//  Mooviest
//
//  Created by Antonio RG on 31/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParticipationParser: NSObject, Parser {
    static func jsonToParticipation(Participation p: JSON)throws -> Participation {
        guard let id = p["celebrity"]["id"].int, let name = p["celebrity"]["name"].string,
            let role = p["role"].int, let character = p["character"].string == nil ? "":p["character"].string,
            let award = p["award"].string
            else {
                throw Error.InvalidParticipation
        }
        return Participation(id: id, name: name, role: role, character: character, award: award)
    }
}