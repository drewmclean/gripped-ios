//
//  ClimbActivity.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

//struct ClimbType {
//    var value : String
//    var label : String
//    init(value:String, label:String) {
//        self.value = value
//        self.label = label
//    }
//}



class Climb: FIRObject, FIRTimestampable {
    typealias T = Climb
    
    struct Keys {
        static let createdAt = "created_at"
        static let modifiedAt = "modified_at"
        static let userId = "user_id"
        static let type = "type"
        static let venue = "venue"
        static let name = "name"
        static let rating = "rating"
        static let ratingComponents = "rating_components"
        static let color = "color"
        static let description = "description"
        static let photoUrl = "photo_url"
    }
    
    override class var objectName: String {
        return "climbs"
    }
    
    override class var userObjectsName: String {
        return "user-climbs"
    }
    
    var userId : String = ""
    var type : String?
    var name : String?
    var venue : String?
    var rating : String?
    var color : String?
    var description : String?
    var createdAt: Date?
    var modifiedAt: Date?
    var photoUrl : NSURL?
    
    override var fieldValues: [AnyHashable : Any] {
        get {
            return [Keys.userId: userId,
                    Keys.type: type ?? "",
                    Keys.venue: venue ?? "",
                    Keys.name: name ?? "",
                    Keys.rating: rating ?? "",
                    Keys.color: color ?? "",
                    Keys.description: description ?? "",
                    Keys.createdAt : createdAt!.isoString(),
                    Keys.modifiedAt : modifiedAt!.isoString()]
        }
        set {
            userId = newValue[Keys.userId] as! String
            venue = newValue[Keys.venue] as? String
            name = newValue[Keys.name] as? String
            rating = newValue[Keys.rating] as? String
            color = newValue[Keys.color] as? String
            description = newValue[Keys.description] as? String
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
