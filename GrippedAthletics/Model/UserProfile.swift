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
    
    static var objectName: String = "profiles"
    
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
    
    var fieldValues: [AnyHashable : Any] {
        get {
            return [Keys.facebookId: facebookId!,
                    Keys.name: name!,
                    Keys.email: email!,
                    Keys.birthday: birthday!,
                    Keys.gender: gender!,
                    Keys.photoPathLarge: photoPathLarge!]
        }
        
        set {
            facebookId = newValue[Keys.facebookId] as? String
            name = newValue[Keys.name] as? String
            email = newValue[Keys.email] as? String
            birthday = newValue[Keys.birthday] as? String
            gender = newValue[Keys.gender] as? String
            photoPathLarge = newValue[Keys.photoPathLarge] as? String
        }
    }

    var userId : String {
        return identifier
    }
    
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
        
        return "\(age!) \(gender!.characters.first!)"
    }

    
    func importFacebookGraph(facebookGraph: UserGraph) {
        self.name = facebookGraph.name
        self.facebookId = facebookGraph.id
        self.email = facebookGraph.email
        self.birthday = facebookGraph.birthday
        self.gender = facebookGraph.gender
        self.photoPathLarge = facebookGraph.picturePath
    }
    
    // MARK: Initializers

    convenience init(userId: String) {
        self.init()
        self.identifier = userId
    }
    
    convenience init(userId: String, facebookGraph : UserGraph) {
        self.init()
        self.identifier = userId
        importFacebookGraph(facebookGraph: facebookGraph)
    }
    
}
