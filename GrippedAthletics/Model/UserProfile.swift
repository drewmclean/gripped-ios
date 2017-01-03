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
        static let facebookId = "facebook_id"
        static let name = "name"
        static let email = "email"
        static let gender = "gender"
        static let birthday = "birthday"
        static let photoPathLarge = "photo_path_large"
        static let photoPathSmall = "photo_path_small"
    }
    
    static var objectRef: FIRDatabaseReference {
        return db.reference(withPath: "profiles")
    }
    
    var uid: String
    var facebookId : String?
    var name : String?
    var email : String?
    var gender : String?
    var birthday: String?
    var photoPathLarge : String?
    var photoPathSmall : String?
    
    lazy var dateFormatter : DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MM/DD/yyyy"
        return df
    }()
    
    var age : Int? {
        return birthDate?.sinceNowInYears()
    }
    
    var birthDate : Date? {
        guard let _ = birthday else { return nil }
        return dateFormatter.date(from: birthday!)
    }
    
    var ageAndGender : String? {
        guard let _ = age else { return nil }
        guard let _ = gender else { return nil }
        
        return "\(age!) - \(gender!)"
    }

    var hashableValue: [AnyHashable:Any] {
        return [Keys.facebookId: facebookId!,
                Keys.name: name!,
                Keys.email: email!,
                Keys.birthday: birthday!,
                Keys.gender: gender!,
                Keys.photoPathLarge: photoPathLarge!]
    }
    
    func importFacebookGraph(facebookGraph: UserGraph) {
        self.facebookId = facebookGraph.id
        self.email = facebookGraph.email
        self.birthday = facebookGraph.birthday
        self.name = facebookGraph.name
        self.gender = facebookGraph.gender
        self.photoPathLarge = facebookGraph.picturePath
    }
    
    // MARK: Fetch
    
    // MARK: Initializers
    init(uid: String) {
        self.uid = uid
        super.init()
    }
    
    init(uid: String, facebookGraph : UserGraph) {
        self.uid = uid
        super.init()
        importFacebookGraph(facebookGraph: facebookGraph)
    }
    
    required init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.uid = snapshot.key
        self.facebookId = snapshotValue[Keys.facebookId] as? String
        self.name = snapshotValue[Keys.name] as? String
        self.email = snapshotValue[Keys.email] as? String
        self.birthday = snapshotValue[Keys.birthday] as? String
        self.photoPathSmall = snapshotValue[Keys.photoPathSmall] as? String
        self.photoPathLarge = snapshotValue[Keys.photoPathLarge] as? String
    }
    
}
