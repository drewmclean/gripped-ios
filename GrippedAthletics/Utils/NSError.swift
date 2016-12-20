//
//  NSError.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/9/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import Foundation

extension NSError {
    
    var errorName : String? {
        return userInfo["error_name"] as? String
    }
}
