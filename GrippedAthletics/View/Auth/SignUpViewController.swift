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
    
    lazy var nameViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Name"
        vc.keyboardType = .default
        vc.autocapitalizationType = .words
        vc.returnKeyType = .next
        vc.fieldTitle = "Name"
        vc.rightBarTitle = "Next"
        vc.delegate = self
        vc.validator = self.validator
        vc.validatorRules = [RequiredRule()]
        return vc
    }()
    
    lazy var emailViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Email Address"
        vc.keyboardType = .emailAddress
        vc.returnKeyType = .next
        vc.fieldTitle = "Email"
        vc.rightBarTitle = "Next"
        vc.delegate = self
        vc.validator = self.validator
        vc.validatorRules = [RequiredRule(), EmailRule()]
        return vc
    }()
    
    lazy var passwordViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Password"
        vc.keyboardType = .default
        vc.returnKeyType = .done
        vc.isSecureTextEntry = true
        vc.rightBarTitle = "Done"
        vc.fieldTitle = "Password"
        vc.delegate = self
        vc.validator = self.validator
        vc.validatorRules = [RequiredRule(), PasswordRule()]
        return vc
    }()
    
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
            
            
            
            
        })
    }

}


