//
//  AuthTextFieldViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import PromiseKit

class AuthTextFieldViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fieldContainerView: UIView!
    @IBOutlet weak var fieldContainerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fieldLabelCenterYConstraint: NSLayoutConstraint!
    
    private var labelIsShown : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fieldLabel.isHidden = true
        textField.text = ""
        textField.observe(keyPath: "text").then { (value: String?) -> Void in
            if value!.isEmpty {
                self.hideFieldLabel()
            } else {
                self.showFieldLabel()
            }
        }
    }
    
    // MARK: Animation
    
    func showFieldLabel() {
        labelIsShown = true
        fieldLabel.alpha = 0
        fieldLabel.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: {
            self.fieldLabel.alpha = 1.0
            self.fieldLabelCenterYConstraint.constant = -20.0
            self.fieldContainerView.layoutIfNeeded()
        }, completion: { (Bool) -> Void in
            
        })
    }
    
    func hideFieldLabel() {
        labelIsShown = false
    }

    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        return true
    }
    
    deinit {
        
    }
}
