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
import FirebaseAuth
import FacebookCore
import FacebookLogin

class Auth: NSObject {
    
    static let instance = Auth()
    
    var firAuth : FIRAuth {
        return FIRAuth.auth()!
    }
    
    var isAuthenticated : Bool {
        return false
    }
    
    var currentUser : FIRUser?
    
    func signIn(withEmail email:String, andPassword password: String) -> Future<FIRUser, NoError> {
        return Future { complete in
            
            firAuth.signIn(withEmail: email, password: password) { (user, error) in
                
                if let e = error {
                    DDLogError("Error signing in user: \(e)")
                    complete(.error(e))
                }
                
                print("User signed in: \(user)")
                complete(.success(user))
            }
            
        }
    }
    
    func signIn(withFacebookAccessToken facebookAccessToken: String) -> Void {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: facebookAccessToken)
        firAuth.signIn(with: credential) { (user, error) in
    
            if let e = error {
                
                return
            }
        }
    
    }
}
