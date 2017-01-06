//
//  FIRObject.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/26/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import CocoaLumberjack
import FirebaseDatabase

protocol FIRTimeStampable {
    var createdAt : String? { get set }
    var createdDate : Date? { get set }
}

protocol FIRObjectRef {
    static var objectName: String { get }
    static var objectRef: FIRDatabaseReference { get }
    
    var fieldValues : [AnyHashable: Any] { get set }
}

class FIRObject {
    
    struct Keys {
        static let createdAt = "created_at"
        static let modifiedAt = "modified_at"
    }
    
    static let db : FIRDatabase = FIRDatabase.database()
    
    var identifier : String = ""
    
    static func childUpdateRefKeys<T: FIRObject, U: FIRObjectRef>(someT: T, someU: U, objectKey: String, userId: String?) -> [String] {
        var keys = ["\(U.objectName)/\(objectKey)"]
        if let _ = userId {
            keys.append("\(User.objectName)-\(U.objectName)/\(userId!)/\(objectKey)")
        }
        return keys
    }
    
    static func create<T: FIRObject, U: FIRObjectRef>(someT: T, someU: U, fieldValues:[AnyHashable:Any], userId:String?, completion:@escaping (Error?, T) -> Void) {
        
        // Create a new unique identifier for the object's parent reference
        let key = U.objectRef.childByAutoId().key
        let childRefKeys = T.childUpdateRefKeys(someT: someT, someU: someU, objectKey: key, userId: userId)
        var childUpdates = [String : Any]()
        childRefKeys.forEach { (key: String) in
            childUpdates[key] = fieldValues
        }
        
        db.reference().updateChildValues(childUpdates) { (error: Error?, ref: FIRDatabaseReference) in
            ref.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
                
//                new.importSnapshot(snapshot: snapshot)
//                completion(error, new)
            })
        }
    }

//    func save(completionror?) -> Void) {
//        let biometric = hashableValue
//        
//        FIRDatabase.database().reference().updateChildValues(childUpdates) { (error: Error?, ref: FIRDatabaseReference) in
//            ref.observeSingleEvent(of: .value, with: { (snapshot: FIRDataSnapshot) in
//                completion(error)
//            })
//        }
//    }
    
    func importSnapshot(snapshot: FIRDataSnapshot) {
        
        (self as! FIRObjectRef).fieldValues = snapshot.value!
        
    }
    
}
