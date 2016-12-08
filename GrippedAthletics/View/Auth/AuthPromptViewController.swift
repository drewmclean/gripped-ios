//
//  AuthViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class AuthPromptViewController: UIViewController {

    @IBOutlet weak var grippedLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        facebookLoginButton.delegate = self
    }
    
}

extension AuthPromptViewController : FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let e = error {
            print(e.localizedDescription)
            showErrorAlert(title: "Facebook Error", message: e.localizedDescription)
            return
        }
        AuthManager.instance.sign
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}
