//
//  FIRUser.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/13/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import FirebaseAuth
import BrightFutures
import Result
import CocoaLumberjack

extension FIRUser {
    
    func changeProfile(changeClosure : (FIRUserProfileChangeRequest) -> Void) -> Future<FIRUserProfileChangeRequest, AnyError> {
        return Future { complete in
            let change = profileChangeRequest()
            changeClosure(change)
            change.commitChanges(completion: { (error:Error?) in
                guard error == nil else {
                    DDLogError(error!.localizedDescription)
                    complete(.failure(AnyError(cause: error!)))
                    return
                }
                complete(.success(change))
            })
        }
    }
    
    func changeProfile(toFacebookUserGraph userGraph: [String:Any]) -> Future<FIRUserProfileChangeRequest, AnyError> {
        
        let email : String = userGraph["email"] as! String
        let birthday : String = userGraph["birthday"] as! String
        let gender : String = userGraph["gender"] as! String
        let name : String = userGraph["name"] as! String
        let picture : [String:Any] = userGraph["picture"] as! [String:Any]
        
        return Future { complete in
            
            let change = profileChangeRequest()
            change.displayName = name
            if let path = picture["url"] as? String {
                change.photoURL = URL(string: path)
            }
            change.commitChanges(completion: { (error:Error?) in
                guard error == nil else {
                    DDLogError(error!.localizedDescription)
                    complete(.failure(AnyError(cause: error!)))
                    return
                }
                complete(.success(change))
            })
        }.andThen { (result: Result<FIRUserProfileChangeRequest, AnyError>) in
            self.updateEmail(email) { (error: Error?) in
                guard error == nil else {
                    DDLogError(error!.localizedDescription)
                    return
                }
                
            }
        }.andThen { (result: Result<FIRUserProfileChangeRequest, AnyError>) in
            
        }
    }
}
