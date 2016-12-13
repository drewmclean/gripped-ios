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
        
        auth.signIn(withEmail: email, andPassword: password).onSuccess { (user: FIRUser) in
            self.enterMainApplication()
        }.onFailure { (error: AnyError) in
            self.showErrorAlert(title: "Login Failed", message: error.localizedDescription)
        }
    }
}
