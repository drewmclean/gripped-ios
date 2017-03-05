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
    
    static var sportValues : [AttemptStyle] =  [onsight, redpoint, flash, project]
    static var boulderValues : [AttemptStyle] =  [onsight, flash, project]
    static var tradValues : [AttemptStyle] =  [onsight, redpoint, flash, project, headpoint]
    
    static var allValues : [AttemptStyle] =  [onsight, redpoint, flash, project, headpoint]
    
}
