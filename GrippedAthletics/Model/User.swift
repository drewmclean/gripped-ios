//
//  User.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import  FirebaseDatabase

class User: FIRObject, FIRObjectRef {
    
    static var objectName: String = "users"
    static var objectRef = FIRDatabaseReference().child(User.objectName)
    
    var fieldValues: [AnyHashable : Any] {
        set {
            
        }
        get {
            return [AnyHashable : Any]()
        }
    }
}
