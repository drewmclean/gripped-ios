//
//  UserProfile.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/14/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserProfile : FIRObject, FIRObjectRef {
    
    struct Keys {
        static let name = "name"
        static let email = "email"
        static let birthday = "birthday"
        static let photoPathLarge = "photo_path_large"
        static let photoPathSmall = "photo_path_small"
    }
    
    static var ref: FIRDatabaseReference {
        return db.reference(withPath: "profiles")
    }
    
    let uid: String
    var name : String = ""
    var email : String?
    var birthday: String?
    var photoPathLarge : String?
    var photoPathSmall : String?
    
    var age : String? {
        return "" // Convert birthday to age
    }
    
    init(authData: FIRUser) {
        self.uid = authData.uid
        self.email = authData.email
    }
    
    init(uid: String, name : String, birthday: String, photoPathLarge: String?, photoPathSmall: String?) {
        self.uid = uid
        self.name = name
        self.birthday = birthday
        self.photoPathLarge = photoPathLarge
        self.photoPathSmall = photoPathSmall
    }
    
//    init(snapshot: FIRDataSnapshot) {
//        key = snapshot.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        self.name = snapshotValue["name"] as! String
//        self.userId = snapshotValue["userId"] as! String
//        
//        self.ref = snapshot.ref
//    }
//    
//    override func importFromSnapshot(snapshot: FIRDataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: AnyObject]
////        name = snapshotValue["name"] as! String
////        addedByUser = snapshotValue["addedByUser"] as! String
////        completed = snapshotValue["completed"] as! Bool
//    }
//    
//    override func toAnyObject() -> Any {
//        return [
//            "name": name,
//            "addedByUser": addedByUser,
//            "completed": completed
//        ]
//    }
    
}
