//
//  UserProfile.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/14/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct UserProfile : FIRObject {
    
    var birthday: String
    let userId: String
    
    init(userId: String, birthday: String, key: String = "") {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    override func importFromSnapshot(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        addedByUser = snapshotValue["addedByUser"] as! String
        completed = snapshotValue["completed"] as! Bool
    }
    
    override func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "completed": completed
        ]
    }
    
}
