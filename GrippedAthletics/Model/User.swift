//
//  User.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import  FirebaseDatabase

class User: FIRObject {
    
    override class var objectName: String { return "users" }
    override class var objectRef: FIRDatabaseReference { return FIRDatabaseReference().child(User.objectName) }
    
    override var fieldValues: [AnyHashable : Any] {
        set {
            
        }
        get {
            return [AnyHashable : Any]()
        }
    }
}
