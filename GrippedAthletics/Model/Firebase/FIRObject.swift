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
    var createdAt : Date? { get set }
    var modifiedAt : Date? { get set }
}

class FIRObject {
    
    static let db : FIRDatabase = FIRDatabase.database()
    
    var identifier : String = ""
    
    class var objectName: String {
        assert(false, "You must override objectName in FIRObject subclass.")
        return ""
    }
    
    class var userObjectsName: String {
        return ""
    }
    
    class var objectRef: FIRDatabaseReference { return db.reference().child(objectName) }
    class var userObjectsRef: FIRDatabaseReference { return db.reference().child(userObjectsName) }
    
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
            keys.append("\(userObjectsName)/\(userId!)/\(objectKey)")
        }
        return keys
    }
    
    static func fetch(key: String, completion: @escaping (Error?, FIRDataSnapshot?) -> Void) {
        let ref = objectRef.child(key)
        ref.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            completion(nil, snapshot)
        }
    }
    
    static func create(fieldValues:[AnyHashable:Any], completion:@escaping (Error?, FIRDataSnapshot?) -> Void) {
        
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
                completion(e, nil)
                return
            }
            let ref = objectRef.child(key)
            ref.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
                completion(nil, snapshot)
            })
        }
    }
    
    func update(fieldValues: [AnyHashable: Any], completion:@escaping (Error?) -> Void)  {
        
        let key = identifier
        let childRefKeys = FIRObject.childUpdateRefKeys(objectKey: key, userId: Auth.instance.currentUser!.uid)
        var childUpdates = [String : Any]()
        childRefKeys.forEach { (key: String) in
            childUpdates[key] = fieldValues
        }
        
        FIRObject.db.reference().updateChildValues(childUpdates) { (error: Error?, ref: FIRDatabaseReference) in
            if let e = error {
                DDLogError(e.localizedDescription)
                completion(e)
                return
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
                self.importSnapshot(snapshot: snapshot)
                completion(nil)
            })
        }
    }
    
    func importSnapshot(snapshot: FIRDataSnapshot) {
        identifier = snapshot.key
        if snapshot.exists() {
            fieldValues = snapshot.value as! [AnyHashable : Any]
        }
    }
    
    public convenience init(snapshot:FIRDataSnapshot) {
        self.init()
        self.importSnapshot(snapshot: snapshot)
    }
    
}
