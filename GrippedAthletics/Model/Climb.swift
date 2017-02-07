//
//  ClimbActivity.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

enum ClimbType : String {
    case sport = "sport"
    case bouldering = "bouldering"
    case trad = "trad"
    case iceMixed = "ice_mixed"
    
    static var allValues = [sport, bouldering, trad, iceMixed]
}

class Climb: FIRObject, FIRTimestampable {
    typealias T = Climb
    
    struct Keys {
        static let createdAt = "created_at"
        static let modifiedAt = "modified_at"
        static let userId = "user_id"
        static let type = "type"
        static let timestamp = "timestamp"
        static let name = "name"
        static let rating = "rating"
        static let color = "color"
        static let notes = "notes"
    }
    
    override class var objectName: String {
        return "climbs"
    }
    
    override class var userObjectsName: String {
        return "user-climbs"
    }
    
    var userId : String = ""
    var type : String?
    var timestamp : Date?
    var name : String?
    var rating : String?
    var color : String?
    var notes : String?
    var createdAt: Date?
    var modifiedAt: Date?
    
    override var fieldValues: [AnyHashable : Any] {
        get {
            return [Keys.userId: userId,
                    Keys.type: type ?? "",
                    Keys.timestamp: timestamp ?? "",
                    Keys.name: name ?? "",
                    Keys.rating: rating ?? "",
                    Keys.color: color ?? "",
                    Keys.notes: notes ?? "",
                    Keys.createdAt : createdAt!.isoString(),
                    Keys.modifiedAt : modifiedAt!.isoString()]
        }
        set {
            userId = newValue[Keys.userId] as! String
            type = newValue[Keys.type] as? String
            timestamp = Date.isoDate(from: newValue[Keys.timestamp] as! String)
            name = newValue[Keys.name] as? String
            rating = newValue[Keys.rating] as? String
            color = newValue[Keys.color] as? String
            notes = newValue[Keys.notes] as? String
            createdAt = Date.isoDate(from: newValue[Keys.createdAt] as! String)
            modifiedAt = Date.isoDate(from: newValue[Keys.modifiedAt] as! String)
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
