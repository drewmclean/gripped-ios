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
        static let gender = "gender"
        static let birthday = "birthday"
        static let photoPathLarge = "photo_path_large"
        static let photoPathSmall = "photo_path_small"
    }
    
    static var ref: FIRDatabaseReference {
        return db.reference(withPath: "profiles")
    }
    
    var uid: String
    var name : String?
    var email : String?
    var gender : String?
    var birthday: String? {
        didSet {
            // set birthDate and age
            
        }
    }
    var photoPathLarge : String?
    var photoPathSmall : String?
    
    var age : Int?
    var birthDate : NSDate?
    
    var anyObjectValue: Any {
        return [Keys.name: name,
                Keys.email: email,
                Keys.birthday: birthday,
                Keys.gender: gender,
                Keys.photoPathLarge: photoPathLarge,
                Keys.photoPathSmall: photoPathSmall]
    }
    
    func importFacebookGraph(facebookGraph: UserGraph) {
        self.email = facebookGraph.email
        self.birthday = facebookGraph.birthday
        self.name = facebookGraph.name
        self.gender = facebookGraph.gender
        self.photoPathLarge = facebookGraph.picturePath
    }
    
    // MARK: Initializers
    
    init(uid: String, facebookGraph : UserGraph) {
        
        self.uid = uid
        super.init()
        importFacebookGraph(facebookGraph: facebookGraph)
    }
    
    required init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.uid = snapshot.key
        self.name = snapshotValue[Keys.name] as! String
        self.email = snapshotValue[Keys.email] as! String
        self.birthday = snapshotValue[Keys.birthday] as! String
        self.photoPathSmall = snapshotValue[Keys.photoPathSmall] as! String
        self.photoPathLarge = snapshotValue[Keys.photoPathLarge] as! String
    }
    
}
