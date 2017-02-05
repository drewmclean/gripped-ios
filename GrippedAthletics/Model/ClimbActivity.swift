//
//  ClimbActivity.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class Activity: FIRObject, FIRTimestampable {
    typealias T = Activity
    
    struct Keys {
        static let createdAt = "created_at"
        static let modifiedAt = "modified_at"
        static let userId = "user_id"
        static let type = "type"
        static let timestamp = "timestamp"
        static let name = "name"
        static let rating = "rating"
        static let composureLevel = "composure_level"
        static let color = "color"
        static let notes = "notes"
        static let style = "style" // Onsight, Redpoint, Flash
        static let numberOfHangs = "numberOfHangs"
    }
    
    override class var objectName: String {
        return "activity"
    }
    
    override class var userObjectsName: String {
        return "user-activity"
    }
    
    var userId : String = ""
    var type : String?
    var timestamp : NSDate?
    var name : String?
    var rating : String?
    var composureLevel : String?
    var color : String?
    var notes : String?
    var style : String?
    var numberOfHangs : String?
    var createdAt: Date?
    var modifiedAt: Date?
    
    override var fieldValues: [AnyHashable : Any] {
        get {
            return [Keys.userId: userId,
                    Keys.type: type ?? "",
                    Keys.timestamp: timestamp ?? "",
                    Keys.name: name ?? "",
                    Keys.rating: rating ?? "",
                    Keys.composureLevel: composureLevel ?? "",
                    Keys.color: color ?? "",
                    Keys.notes: notes ?? "",
                    Keys.style: style ?? "",
                    Keys.numberOfHangs: numberOfHangs ?? "",
                    Keys.createdAt : createdAt!.isoString(),
                    Keys.modifiedAt : modifiedAt!.isoString()]
        }
        set {
            userId = newValue[Keys.userId] as! String
            height = newValue[Keys.height] as? String
            weight = newValue[Keys.weight] as? String
            bodyComposition = newValue[Keys.bodyComposition] as? String
            apeIndex = newValue[Keys.apeIndex] as? String
            forearmLength = newValue[Keys.forearmLength] as? String
            forearmCircumference = newValue[Keys.forearmCircumference] as? String
            createdAt = Date.isoDate(from: newValue[Keys.createdAt] as! String)
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
