//
//  AuthTextFieldViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

class AuthTextFieldViewController: UIViewController, UITextFieldDelegate, KeyboardAnimator {
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(AuthTextFieldViewController.textDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
        
        addKeyboardHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    
    // MARK: Animation
    
    func showFieldLabel() {
        if !labelIsShown {
            labelIsShown = true
            fieldLabel.alpha = 0
            fieldLabel.isHidden = false
            UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                self.fieldLabel.alpha = 1.0
                self.fieldLabelCenterYConstraint.constant = -20.0
                self.fieldContainerView.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
                
            })
        }
    }
    
    func hideFieldLabel() {
        if labelIsShown {
            labelIsShown = false
            UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                self.fieldLabel.alpha = 0
                self.fieldLabelCenterYConstraint.constant = 0.0
                self.fieldContainerView.layoutIfNeeded()
            }, completion: { (Bool) -> Void in
                self.fieldLabel.isHidden = true
            })
        }
    }
    
    // MARK: Notifications
    
    func textDidChange(notification:Notification) {
        if textField.text!.isEmpty {
            self.hideFieldLabel()
        } else {
            self.showFieldLabel()
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    // MARK: KeyboardAnimator 
    func keyboardShowAnimation(keyboardFrame: CGRect) {
        fieldContainerViewBottomConstraint.constant = keyboardFrame.size.height
    }
    
    func keyboardHideAnimation(keyboardFrane: CGRect) {
        fieldContainerViewBottomConstraint.constant = 0
    }
    
    // MARK: Deinit
    
    deinit {
        
    }
}
