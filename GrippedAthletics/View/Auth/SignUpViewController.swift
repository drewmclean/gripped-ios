//
//  SignUpViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

class SignUpViewController: UINavigationController {

    lazy var emailViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Email Address"
        vc.keyboardType = .emailAddress
        vc.returnKeyType = .next
        vc.fieldTitle = "Email"
        vc.numberOfSteps = 2
        vc.currentStep = 1
        vc.doneClosure = { (value : String) -> Void in
            self.showPassword()
        }
        return vc
    }()
    
    lazy var passwordViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Password"
        vc.keyboardType = .default
        vc.returnKeyType = .done
        vc.fieldTitle = "Password"
        vc.numberOfSteps = 2
        vc.currentStep = 2
        vc.doneClosure = { (value : String) -> Void in
            self.createAccount()
        }
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([emailViewController], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showPassword() {
        pushViewController(passwordViewController, animated: true)
    }
    
    func createAccount() {
        
    }

}
