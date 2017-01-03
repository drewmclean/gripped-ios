//
//  FIRObject.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/26/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import FirebaseDatabase

protocol FIRTimeStampable {
    var createdAt : String? { get set }
    var createdDate : Date? { get set }
}

protocol FIRObjectRef {
    static var objectRef: FIRDatabaseReference { get }
    var hashableValue : [AnyHashable: Any] { get }
    init (snapshot: FIRDataSnapshot)
}

class FIRObject {
    
    struct Keys {
        static let createdAt = "created_at"
        static let modifiedAt = "modified_at"
    }
    
    static let db : FIRDatabase = FIRDatabase.database()
    
    var identifier : String = ""
}
