//
//  AuthTextFieldViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

class AuthTextFieldViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fieldContainerView: UIView!
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fieldLabelCenterYConstraint: NSLayoutConstraint!
    
    var placeholder : String?
    var keyboardType : UIKeyboardType = .default
    var returnKeyType : UIReturnKeyType = .default
    var isSecureTextEntry : Bool = false
    var autocapitalizationType : UITextAutocapitalizationType = .none
    var fieldTitle : String?
    var doneClosure : ((String) -> Void)!
    var validationClosure : ((String?) -> Bool)!
    
    private var labelIsShown : Bool = false
    
    var backBarLabel : String?
    var rightBarTitle : String?
    
    lazy var textBorder : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        self.fieldContainerView.addSubview(view)
        return view
    }()
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.backgroundColor = UIColor.clear
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.autocapitalizationType = autocapitalizationType
        
        fieldLabel.text = fieldTitle
        fieldLabel.isHidden = true
        textField.text = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(AuthTextFieldViewController.textDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func updateViewConstraints() {
        textBorder.snp.updateConstraints { (make) in
            make.left.equalTo(fieldContainerView)
            make.right.equalTo(fieldContainerView)
            make.bottom.equalTo(textField.snp.bottom)
            make.height.equalTo(0.5)
        }
        super.updateViewConstraints()
    }
    
    // MARK: Animation
    
    func showFieldLabel() {
        if !labelIsShown {
            labelIsShown = true
            fieldLabel.alpha = 0
            fieldLabel.isHidden = false
            UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                self.fieldLabel.alpha = 1.0
                self.fieldLabelCenterYConstraint.constant = -24.0
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
    
    // MARK: Validation 
    
    func validateText() -> Bool {
        return validationClosure(textField.text)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if validateText() {
            doneClosure(textField.text!)
            return true
        }
        return false
    }
    
    // MARK: Action
    
    func rightItemTapped(sender: UIBarButtonItem) {
        if validateText() {
            doneClosure(textField.text!)
        }
    }
    
    // MARK: Deinit
    
    deinit {
        
    }
}
