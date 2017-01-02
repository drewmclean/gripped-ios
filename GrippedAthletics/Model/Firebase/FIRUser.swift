//
//  FIRUser.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/13/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase
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
    
    func changeProfile(withFacebookUserGraph userGraph: UserGraph) -> Future<FIRUserProfileChangeRequest, AnyError> {
        
        return Future { complete in
            
            let change = profileChangeRequest()
            change.displayName = userGraph.name
            if let path = userGraph.picturePath {
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
            self.updateEmail(userGraph.email!) { (error: Error?) in
                guard error == nil else {
                    DDLogError(error!.localizedDescription)
                    return
                }
            }
        }.andThen { (result: Result<FIRUserProfileChangeRequest, AnyError>) in
            let currentProfileRef = UserProfile.ref.child(self.uid)
            currentProfileRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
                print("Post FB Graph Profile Observe: \(snapshot)")
                
                var profile : UserProfile!
                if snapshot.exists() {
                    profile = UserProfile(snapshot: snapshot)
                    profile.importFacebookGraph(facebookGraph: userGraph)
                } else {
                    profile = UserProfile(uid: self.uid, facebookGraph: userGraph)
                }
                
                let updateValue = profile.anyObjectValue
                currentProfileRef.setValue(updateValue) { (error: Error?, ref: FIRDatabaseReference) in
                    guard error == nil else {
                        DDLogError(error!.localizedDescription)
                        return
                    }
                }
            }
            
        }
    }
}
