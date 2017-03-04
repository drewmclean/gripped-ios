//
//  Activity.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/6/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class Attempt: FIRObject, FIRTimestampable {
    typealias T = Attempt
    
    struct Keys {
        static let createdAt = "created_at"
        static let modifiedAt = "modified_at"
        static let userId = "user_id"
        static let climbId = "climb_id"
        static let climbType = "climb_type"
        static let attemptedAt = "attempted_at"
        static let composureLevel = "composure_level"
        static let fearLevel = "fear_level"
        static let notes = "notes"
        static let style = "style" // Onsight, Redpoint, Flash, Project
        static let didSend = "did_send"
        static let numberOfHangs = "number_of_hangs"
    }
    
    override class var objectName: String {
        return "attempt"
    }
    
    override class var userObjectsName: String {
        return "user-attempt"
    }
    
    var userId : String!
    var climbId : String!
    var climbType : String!
    var attemptedAt : Date?
    var composureLevel : Int?
    var fearLevel : Int?
    var notes : String?
    var style : String? // AttemptStyle.rawValue
    var didSend : Bool = false
    var numberOfHangs : Int?
    var createdAt: Date?
    var modifiedAt: Date?
    
    override var fieldValues: [AnyHashable : Any] {
        get {
            return [Keys.userId: userId,
                    Keys.climbId : climbId ?? "",
                    Keys.climbType : climbType ?? "",
                    Keys.attemptedAt: climbType ?? "",
                    Keys.composureLevel: composureLevel ?? 0,
                    Keys.fearLevel: fearLevel ?? 0,
                    Keys.notes: notes ?? "",
                    Keys.style: style ?? "",
                    Keys.numberOfHangs: numberOfHangs ?? 0,
                    Keys.didSend : didSend ?? false,
                    Keys.createdAt : createdAt!.isoString(),
                    Keys.modifiedAt : modifiedAt!.isoString()]
        }
        set {
            userId = newValue[Keys.userId] as! String
            climbId = newValue[Keys.climbId] as! String
            climbType = newValue[Keys.climbType] as! String
            attemptedAt = Date.isoDate(from: newValue[Keys.attemptedAt] as! String)
            composureLevel = Int(newValue[Keys.composureLevel] as! String)
            fearLevel = Int(newValue[Keys.fearLevel] as! String)
            notes = newValue[Kefys.notes] as? String
            style = newValue[Keys.style] as? String
            numberOfHangs = Int(newValue[Keys.numberOfHangs] as! String)
            createdAt = Date.isoDate(from: newValue[Keys.createdAt] as! String)
            modifiedAt = Date.isoDate(from: newValue[Keys.modifiedAt] as! String)
        }
    }
    
    // MARK: Initializers
    convenience init(identifier : String, userId : String, climbId : String) {
        self.init(id: identifier)
        self.userId = userId
        self.climbId = climbId
    }
    
    required convenience init(id: String) {
        self.init(id: id)
        self.userId = ""
        self.climbId = ""
    }
}
