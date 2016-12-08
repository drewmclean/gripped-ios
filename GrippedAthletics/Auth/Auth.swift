//
//  AuthManager.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import CocoaLumberjack
import UIKit
import BrightFutures
import FutureProofing
import Result
import FirebaseAuth
import FacebookCore
import FacebookLogin

class Auth: NSObject {
    
    static let instance = Auth()
    
    var firAuth : FIRAuth {
        return FIRAuth.auth()!
    }
    
    var isAuthenticated : Bool {
        if let accessToken = AccessToken.current {
            DDLogInfo("Facebook token exists: \(accessToken)")
        }else{
            print("Not logged In.")
        }
        
        if let user = currentUser {
            return true
        }
        return false
    }
    
    var currentUser : FIRUser? {
        return firAuth.currentUser
    }
    
    func signUp(withEmail email : String, andPassword password : String) -> Future<FIRUser, AnyError> {
        return Future { complete in
            self.firAuth.createUser(withEmail: email, password: password) { (user: FIRUser?, error: Error?) in
                if let e = error {
                    DDLogError("Error creating user: \(e)")
                    complete(.failure(AnyError(cause: e)))
                    return
                }
                
                DDLogInfo("User created: \(user!)")
                complete(.success(user!))
            }
        }
    }
    
    func signIn(withEmail email:String, andPassword password: String) -> Future<FIRUser, AnyError> {
        return Future { complete in
            self.firAuth.signIn(withEmail: email, password: password) { (user, error) in
                if let e = error {
                    DDLogError("Error signing in user: \(e)")
                    complete(.failure(AnyError(cause: e)))
                    return
                }
                
                DDLogInfo("User signed in: \(user!)")
                complete(.success(user!))
            }
        }
    }
    
    func signIn(withFacebookAccessToken facebookAccessToken: String) -> Future<FIRUser, AnyError> {
        return Future { complete in
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: facebookAccessToken)
            self.firAuth.signIn(with: credential) { (user, error) in
            
                if let e = error {
                    DDLogError("Error signing in user: \(e)")
                    complete(.failure(AnyError(cause: e)))
                    return
                }
                
                // TODO:    Check to see if there an existing credential that matches their FB email address.  If so then ask them to enter password for that email, and then authenticate them via email/password.  If that succeeds then authenticate them via Facebook.
                
                DDLogInfo("User signed in: \(user!)")
                complete(.success(user!))
            }
        }
    }
}
