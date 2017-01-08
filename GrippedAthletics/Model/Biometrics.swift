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
    
    static func valueFromRaw(raw:String) -> SignValue? {
        return SignValue.allValues.filter { (signValue : SignValue) -> Bool in
            return signValue.rawValue == raw
        }.first
    }
    
    static let allValues = [plus, minus]
}

class Biometrics: FIRObject, FIRTimestampable {
    typealias T = Biometrics
    
    struct Keys {
        static let createdAt = "created_at"
        static let userId = "user_id"
        static let height = "height"
        static let weight = "weight"
        static let bodyComposition = "body_composition"
        static let apeIndex = "ape_index"
        static let forearmLength = "forearm_length"
        static let forearmCircumference = "forearm_circumference"
    }
    
    override class var objectName: String {
        return "biometrics"
    }
    
    override class var objectRef: FIRDatabaseReference {
        return db.reference(withPath: objectName)
    }
    
    var userId : String = ""
    var height : String?
    var weight : String?
    var bodyComposition : String?
    var apeIndex : String?
    var forearmLength : String?
    var forearmCircumference : String?
    var createdAt : String?
    var createdDate : Date?
    
    var apeSign : String? {
        guard let ape = apeIndex else { return nil }
        return ape.substring(to: 0)
    }
    
    var apeLength : String? {
        return apeIndex?.trimmingCharacters(in: CharacterSet(charactersIn: "+-"))
    }
    
    override var fieldValues: [AnyHashable : Any] {
        get {
            return [Keys.userId: userId,
                    Keys.height: height!,
                    Keys.weight: weight!,
                    Keys.bodyComposition: bodyComposition!,
                    Keys.apeIndex: apeIndex!,
                    Keys.forearmLength: forearmLength!,
                    Keys.forearmCircumference: forearmCircumference!,
                    FIRObject.Keys.createdAt : createdAt!]
        }
        set {
            userId = newValue[Keys.userId] as! String
            height = newValue[Keys.height] as? String
            weight = newValue[Keys.weight] as? String
            bodyComposition = newValue[Keys.bodyComposition] as? String
            apeIndex = newValue[Keys.apeIndex] as? String
            forearmLength = newValue[Keys.forearmLength] as? String
            forearmCircumference = newValue[Keys.forearmCircumference] as? String
        }
    }
    
    // MARK: Initializrers
    convenience init(identifier : String, userId : String) {
        self.init(id: identifier)
        self.userId = userId
    }
    
    required convenience init(id: String) {
        self.init(id: id)
        self.userId = ""
    }
}
