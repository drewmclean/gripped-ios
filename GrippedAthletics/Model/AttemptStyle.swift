//
//  AttemptStyle.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

enum AttemptStyle : String, StringRepresentable {
    
    case onsight = "onsight"
    case redpoint = "redpoint"
    case flash = "flash"
    case project = "project"
    case headpoint = "headpoint"
    
    var allValues : [ClimbStyle] =  [onsight, redpoint, flash, project, headpoint]
    
}
