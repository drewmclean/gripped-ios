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

public struct AnyError: Error {
    public let cause: Error
    
    public init(cause: Error) {
        self.cause = cause
    }
}

extension AnyError: ErrorProtocolConvertible {
    
    public static func error(from error: Swift.Error) -> AnyError {
        return AnyError(cause: error)
    }
}



class Auth: NSObject {
    
    static let instance = Auth()
    
    var firAuth : FIRAuth {
        return FIRAuth.auth()!
    }
    
    var isAuthenticated : Bool {
        return false
    }
    
    var currentUser : FIRUser?
    
    func signIn(withEmail email:String, andPassword password: String) -> Future<FIRUser, AnyError> {
        
        return Future { complete in
            firAuth.signIn(withEmail: email, password: password) { (user, error) in
                if let e = error {
                    DDLogError("Error signing in user: \(e)")
                    complete(.failure(AnyError(cause: e)))
                    return
                }
                
                print("User signed in: \(user!)")
                complete(.success(user!))
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
