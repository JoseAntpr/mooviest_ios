//
//  Errors.swift
//  Mooviest
//
//  Created by Antonio RG on 31/8/16.
//  Copyright © 2016 Mooviest. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}
enum ErrorMovie:Error {
    case invalidRating
    case invalidMovie
    case invalidParticipation
    case invalidResponseAPI
}
