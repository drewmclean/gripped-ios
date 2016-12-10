//
//  NSUserDefaults.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/9/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    struct Keys {
        static let lastLoggedInEmail : String = "lastLoggedInEmail"
    }

    var lastLoggedInEmail: String? {
        get {
            return string(forKey: UserDefaults.Keys.lastLoggedInEmail)
        }
        set {
            setValue(newValue, forKey: UserDefaults.Keys.lastLoggedInEmail)
            synchronize()
        }
    }
}
