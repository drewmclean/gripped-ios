//
//  SignUpViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import SnapKit
import SwiftValidator
import FirebaseAuth

class SignUpViewController: AuthFlowViewController {
    
    override var fieldViewControllers : [AuthTextFieldViewController] {
        return [self.nameViewController, self.emailViewController, self.passwordViewController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: API

    override public func submitForm() {
        let email = emailViewController.fieldValue!
        let password = passwordViewController.fieldValue!
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            
            if let e = error {
                print("Error creating user: \(e)")
                self.showErrorAlert(title: "We're Sorry", message: e.localizedDescription)
                return
            }
            
            print("User created: \(user)")
            
        })
    }

}


