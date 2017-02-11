//
//  ClimbType.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/10/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

enum ClimbType : String, StringRepresentable {
    case sport = "sport"
    case boulder = "boulder"
    case trad = "trad"
    case iceMixed = "ice_mixed"
    
    static var allValues = [sport, boulder, trad, iceMixed]
}

