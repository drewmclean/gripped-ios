//
//  AuthManager.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class AuthManager: NSObject {
    
    static let instance = AuthManager()
    
    var isAuthenticated : Bool {
        return false
    }
}
