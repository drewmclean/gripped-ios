//
//  Biometric.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum SignValue : String {
    case plus = "+"
    case minus = "-"
    
    static let allValues = [plus, minus]
}

class Biometrics: FIRObject, FIRObjectRef, FIRTimeStampable {
    
    struct Keys {
        static let height = "height"
        static let weight = "weight"
        static let bodyComposition = "body_composition"
        static let apeIndex = "ape_index"
        static let forearmLength = "forearm_length"
        static let forearmCircumference = "forearm_circumference"
    }
    
    static var objectRef: FIRDatabaseReference {
        return db.reference(withPath: "biometrics")
    }
    
    var height : String?
    var weight : String?
    var bodyComposition : String?
    var apeIndex : String?
    var forearmLength : String?
    var forearmCircumference : String?
    var createdAt : String?
    var createdDate : Date?
    
    var hashableValue : [AnyHashable: Any] {
        return [Keys.height: height!,
                Keys.weight: weight!,
                Keys.bodyComposition: bodyComposition!,
                Keys.apeIndex: apeIndex!,
                Keys.forearmLength: forearmLength!,
                Keys.forearmCircumference: forearmCircumference!,
                FIRObject.Keys.createdAt : createdAt!]
    }

    required init (snapshot: FIRDataSnapshot) {
        let value = snapshot.value as! [String : Any]
        height = value[Keys.height] as? String
        weight = value[Keys.weight] as? String
        bodyComposition = value[Keys.bodyComposition] as? String
        apeIndex = value[Keys.apeIndex] as? String
        forearmLength = value[Keys.forearmLength] as? String
        forearmCircumference = value[Keys.forearmCircumference] as? String
    }
}