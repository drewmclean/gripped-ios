//
//  AuthViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import CocoaLumberjack
import Result

class AuthPromptViewController: UIViewController {

    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var grippedLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var tempEmail : String?
    
    lazy var facebookLoginButton : LoginButton = {
       let button = LoginButton(readPermissions: [.email, .publicProfile])
        button.delegate = self
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        buttonStackView.insertArrangedSubview(facebookLoginButton, at: 0)
    }
    
    // MARK: Navigation
    
    func presentPasswordOnlyViewController() {
        performSegue(withIdentifier: "presentPasswordOnly", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentPasswordOnly" {
            if let nav = segue.destination as? UINavigationController {
                if let vc = nav.childViewControllers.first as? PasswordOnlyViewController {
                    vc.email = self.tempEmail
                    vc.promptText = "A GrippedAthletics account already exists for your facebook email '\(self.tempEmail!)'.  Please enter your password to link your facebook to this account."
                }
            }
        }
    }
}

extension AuthPromptViewController : LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            DDLogError(error.localizedDescription)
            showErrorAlert(title: "Facebook Error", message: error.localizedDescription)
        case .cancelled:
            DDLogInfo("Facebook login was cancelled.")
        case .success(let grantedPermissions, let declinedPermissions, let token):
            DDLogInfo("Facebook login succeeded with token\(token), granted: \(grantedPermissions) declined: \(declinedPermissions)")
            
            auth.verifyFBProviderExists().onSuccess { (result:(String, Bool )) in
                let providerExists = result.1
                if providerExists == true {
                    self.tempEmail = result.0
                    self.presentPasswordOnlyViewController()
                } else {
                    self.auth.signIn(withFBAccessToken: token.authenticationToken).onSuccess { (user: FIRUser) in
                        self.dismiss(animated: true, completion: nil)
                    }.onFailure { (e: AnyError) in
                        self.showErrorAlert(title: "Login Error", message: e.localizedDescription)
                    }
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
}
