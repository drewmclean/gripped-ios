//
//  PasswordOnlyViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 12/8/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordOnlyViewController: AuthFlowViewController {
    
    var email : String!
    var promptText : String?
    
    override var fieldViewControllers : [AuthTextFieldViewController] {
        return [passwordViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordViewController.promptText = promptText
    }
    
    // MARK: API
    
    override public func submitForm() {
        let password = passwordViewController.fieldValue!
        
        auth.signIn(withEmail: email, andPassword: password).onSuccess { (user: FIRUser) in
            self.enterMainApplication()
            }.onFailure { (error: AnyError) in
                self.showErrorAlert(title: "Login Failed", message: error.localizedDescription)
        }
    }
}
