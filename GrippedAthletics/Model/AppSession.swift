//
//  AppSession.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/14/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import FirebaseDatabase
import FirebaseCore

class AppSession {
    
    static let session = AppSession()
    
    var db : FIRDatabase {
        return FIRDatabase.database()
    }
    
    var profile : UserProfile?
    
}
