//
//  SignInViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import SnapKit
import SwiftValidator
import FirebaseAuth

class SignInViewController: AuthFlowViewController {
    
    override var fieldViewControllers : [AuthTextFieldViewController] {
        return [emailViewController, passwordViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: API
    
    override public func submitForm() {
        let email = emailViewController.fieldValue!
        let password = passwordViewController.fieldValue!
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            
            if let e = error {
                print("Error signing in user: \(e)")
                self.showErrorAlert(title: "We're Sorry", message: e.localizedDescription)
                return
            }
            
            print("User signed in: \(user)")
            self.enterMainApplication()
        })
    }
}
