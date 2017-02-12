//
//  ClimbVenue.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/10/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

enum ClimbVenue : String, StringRepresentable {
    case indoor = "indoor"
    case outdoor = "outdoor"
    static var allValues = [indoor, outdoor]
}

