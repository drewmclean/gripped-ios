//
//  FIRObject.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/26/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import CocoaLumberjack
import FirebaseDatabase

protocol FIRTimestampable {
    var createdAt : String? { get set }
    var createdDate : Date? { get set }
}

class FIRObject {
    
    struct Keys {
        static let createdAt = "created_at"
        static let modifiedAt = "modified_at"
    }
    
    static let db : FIRDatabase = FIRDatabase.database()
    
    var identifier : String = ""
    
    class var objectName: String {
        return ""
    }
    
    class var objectRef: FIRDatabaseReference { return db.reference().child(objectName) }
    
    var fieldValues : [AnyHashable: Any] {
        get {
            return [AnyHashable: Any]()
        }
        set {
            
        }
    }
    
    static func childUpdateRefKeys(objectKey: String, userId: String?) -> [String] {
        var keys = ["\(objectName)/\(objectKey)"]
        if let _ = userId {
            keys.append("\(User.objectName)-\(objectName)/\(userId!)/\(objectKey)")
        }
        return keys
    }
    
    static func fetch<T: FIRObject>(someT: T, key: String, completion: @escaping (Error?, T?) -> Void) {
        let ref = T.objectRef.child(key)
        ref.observe(.value) { (snapshot: FIRDataSnapshot) in
            if snapshot.exists() {
                
            }
        }
    }
    
    static func create<T: FIRObject>(fieldValues:[AnyHashable:Any], completion:@escaping (Error?, T?) -> Void) {
        
        // Create a new unique identifier for the object's parent reference
        let key = objectRef.childByAutoId().key
        let childRefKeys = childUpdateRefKeys(objectKey: key, userId: Auth.instance.currentUser!.uid)
        var childUpdates = [String : Any]()
        childRefKeys.forEach { (key: String) in
            childUpdates[key] = fieldValues
        }
        
        db.reference().updateChildValues(childUpdates) { (error: Error?, ref: FIRDatabaseReference) in
            if let e = error {
                DDLogError(e.localizedDescription)
                
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
                
            })
        }
    }
    
//    func save<T: FIRObject, U: FIRObjectRef>(completion:@escaping (Error?, T) -> Void, someU: U, someT: T?)  {
//        
//        let key = identifier
//        let childRefKeys = T.childUpdateRefKeys(objectKey: key, userId: Auth.instance.currentUser!.uid, someU: someU)
//        var childUpdates = [String : Any]()
//        let values = someU.fieldValues
//        childRefKeys.forEach { (key: String) in
//            childUpdates[key] = values
//        }
//        FIRObject.db.reference().updateChildValues(childUpdates) { (error: Error?, ref: FIRDatabaseReference) in
//            ref.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
//                
//            })
//        }
//    }
    
    func importSnapshot(snapshot: FIRDataSnapshot) {
        identifier = snapshot.key
        if snapshot.exists() {
            fieldValues = snapshot.value as! [AnyHashable : Any]
        }
    }
    
    required init(id: String) {
        
    }
    
}
