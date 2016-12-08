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
        
        
       
    }

}


