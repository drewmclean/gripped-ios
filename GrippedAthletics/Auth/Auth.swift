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

enum AuthError : Error {
    case NoCredentialsStored
}

class Auth: NSObject {
    
    static let instance = Auth()
    
    var firAuth : FIRAuth {
        return FIRAuth.auth()!
    }
    
    var currentUser : FIRUser? {
        return firAuth.currentUser
    }
    
    var lastLoggedInEmail : String? {
        get {
            return UserDefaults.standard.lastLoggedInEmail
        }
        set {
            UserDefaults.standard.lastLoggedInEmail = newValue
        }
    }
    
    func attemptToAuthenticate() -> Future<FIRUser, AnyError> {
        return Future { complete in
            if let facebookAccessToken = AccessToken.current {
                DDLogInfo("Facebook token exists: \(facebookAccessToken)")
                // Autheticate via FB
                signIn(withFBAccessToken: facebookAccessToken.authenticationToken).onSuccess { (user: FIRUser) in
                    complete(.success(user))
                }.onFailure { (error: AnyError) in
                    complete(.failure(error))
                }
            } else if let storedEmail = lastLoggedInEmail {
                DDLogInfo("Not logged In.")
                if let storedPassword = KeyStore.instance.password(forEmail: storedEmail) {
                    signIn(withEmail: storedEmail, andPassword: storedPassword).onSuccess{ (user: FIRUser) in
                        complete(.success(user))
                    }.onFailure { (error: AnyError) in
                        complete(.failure(error))
                    }
                }
            } else {
                complete(.failure(AnyError(cause: AuthError.NoCredentialsStored)))
            }
        }
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
                self.storeCredentials(email: email, password: password)
                
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
                self.storeCredentials(email: email, password: password)
                complete(.success(user!))
            }
        }
    }
    
    internal func storeCredentials(email: String, password: String) {
        lastLoggedInEmail = email
        KeyStore.instance.savePassword(password: password, forEmail: email)
    }
    
    // Returns a Boolean (True if FIRAuth found an email/password account that matches their FB email
    func verifyFBProviderExists() -> Future<(String, Bool), AnyError> {
        return Future { complete in
            // Check for an account that matches their facebook email
            let request:GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"email"])
            request.start { (response: HTTPURLResponse?, result: GraphRequestResult<GraphRequest>) in
                switch result {
                case .success(let value):
                    if let dict = value.dictionaryValue {
                        DDLogVerbose("FB User Graph: \(dict)")
                        if let fbEmail : String = dict["email"] as? String {
                            self.firAuth.fetchProviders(forEmail: fbEmail) { (providers: [String]?, error: Error?) in
                                if let e = error {
                                    DDLogError(e.localizedDescription)
                                    complete(.failure(AnyError(cause: e)))
                                    return
                                } else {
                                    DDLogInfo("FIR Providers for email: \(fbEmail) \n\(providers)")
                                    if let p = providers {
                                        let accountExists = p.contains("password")
                                        complete(.success((fbEmail, accountExists)))
                                    }
                                }
                            }
                        }
                    }

                case .failed(let error):
                    DDLogError(error.localizedDescription)
                    complete(.failure(AnyError(cause: error)))
                }
            }
        }
    }
    
    func signIn(withFBAccessToken fbAccessToken: String) -> Future<FIRUser, AnyError> {
        return Future { complete in
            
            // Check for an account that matches their facebook email
            let request:GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"email"])
            request.start { (response: HTTPURLResponse?, result: GraphRequestResult<GraphRequest>) in
                switch result {
                case .success(let value):
                    if let dict = value.dictionaryValue {
                        DDLogVerbose("FB User Graph: \(dict)")
                        
                    }
                case .failed(let error):
                    DDLogError(error.localizedDescription)
                    complete(.failure(AnyError(cause: error)))
                }
            }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: fbAccessToken)
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
    
    func linkFBCredential(withEmail email:String, andPassword password:String, andFBAccessToken fbAccessToken:String) -> Future<FIRUser, AnyError> {
        return Future { complete in
            let fbCredential = FIRFacebookAuthProvider.credential(withAccessToken: fbAccessToken)
            signIn(withEmail: email, andPassword: password).onSuccess { (user: FIRUser) in
                user.link(with: fbCredential) { (linkedUser: FIRUser?, error: Error?) in
                    if let e = error {
                        DDLogError("Error signing in user: \(e)")
                        complete(.failure(AnyError(cause: e)))
                        return
                    }
                    DDLogInfo("Facebook credential successfully linked for \(email)")
                    complete(.success(linkedUser!))
                }
            }
        }
    }
    
}
