//
//  AppSession.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/14/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

class AppSession {
    
    static let session = AppSession()
    
    var profile : UserProfile?
    
    var firUser : FIRUser? {
        didSet {
            
        }
    }
    
    init () {
        
        
    }
}
