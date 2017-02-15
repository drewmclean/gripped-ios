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
        static let timestamp = "timestamp"
        static let fearLevel = "fear_level"
        static let composureLevel = "composure_level"
        static let notes = "notes"
        static let style = "style" // Onsight, Redpoint, Flash
        static let hangCount = "hang_count"
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
    var timestamp : Date?
    var composureLevel : String?
    var notes : String?
    var style : String?
    var hangCount : Int?
    var createdAt: Date?
    var modifiedAt: Date?
    
    override var fieldValues: [AnyHashable : Any] {
        get {
            return [Keys.userId: userId,
                    Keys.climbId : climbId ?? "",
                    Keys.climbType : climbType ?? "",
                    Keys.timestamp: timestamp ?? "",
                    Keys.composureLevel: composureLevel ?? "",
                    Keys.notes: notes ?? "",
                    Keys.style: style ?? "",
                    Keys.hangCount: hangCount ?? 0,
                    Keys.createdAt : createdAt!.isoString(),
                    Keys.modifiedAt : modifiedAt!.isoString()]
        }
        set {
            userId = newValue[Keys.userId] as! String
            climbId = newValue[Keys.climbId] as! String
            climbType = newValue[Keys.climbType] as! String
            timestamp = Date.isoDate(from: newValue[Keys.timestamp] as! String)
            composureLevel = newValue[Keys.composureLevel] as? String
            notes = newValue[Keys.notes] as? String
            style = newValue[Keys.style] as? String
             = Int(newValue[Keys.hangCount])
            createdAt = Date.isoDate(from: newValue[Keys.createdAt] as! String)
            modifiedAt = Date.isoDate(from: newValue[Keys.modifiedAt] as! String)
        }
    }
    
    // MARK: Initializrers
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
