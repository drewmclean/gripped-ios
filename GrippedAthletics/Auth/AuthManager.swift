//
//  AuthManager.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin

class AuthManager: NSObject {
    
    static let instance = AuthManager()
    
    var isAuthenticated : Bool {
        return false
    }
    
    var currentUser : FIRUser?
             
    func signIn(withEmail email:String, andPassword password: String) -> Void {
        
    }
    
    func signIn(withFacebookAccessToken facebookAccessToken: String) -> Void {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: facebookAccessToken)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
    
        if let e = error {
            self.showErrorAlert(title: "Sign In Error", message: e.localizedDescription)
            return
        }
    
    }
}
