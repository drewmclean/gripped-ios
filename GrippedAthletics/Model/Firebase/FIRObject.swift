//
//  FIRObject.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/26/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import FirebaseDatabase

protocol FIRObjectRef {
    static var ref : FIRDatabaseReference { get }
    var anyObjectValue : Any { get }
    init (snapshot: FIRDataSnapshot)
}

class FIRObject {
    
    static let db : FIRDatabase = FIRDatabase.database()
    
    var identifier : String = ""
}
