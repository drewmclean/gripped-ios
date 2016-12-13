//
//  AuthTextFieldViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import SwiftValidator

protocol AuthTextFieldViewControllerDelegate {
    func didFinishTextEntry(controller : AuthTextFieldViewController)
}

class AuthTextFieldViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fieldContainerView: UIView!
    @IBOutlet weak var promptLabelContainer: UIView!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var promptLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fieldLabelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var invalidMessageLabel: UILabel!
    
    var delegate : AuthTextFieldViewControllerDelegate?
    var promptText : String? {
        didSet {
            promptLabel?.text = promptText
            updateViewConstraints()
        }
    }
    var validator : Validator!
    var validatorRules : [Rule]!
    var placeholder : String?
    var keyboardType : UIKeyboardType = .default
    var returnKeyType : UIReturnKeyType = .default
    var isSecureTextEntry : Bool = false
    var autocapitalizationType : UITextAutocapitalizationType = .none
    var autocorrectionType : UITextAutocorrectionType = .no
    var fieldTitle : String?
    var fieldValue : String? {
        return textField.text
    }
    
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
        
        validator.registerField(textField, errorLabel: invalidMessageLabel, rules: validatorRules)
        
        promptLabel.text = promptText
        
        textField.backgroundColor = UIColor.clear
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.autocorrectionType = autocorrectionType
        textField.autocapitalizationType = autocapitalizationType
        textField.text = ""
        textField.delegate = self
        
        fieldLabel.text = fieldTitle
        fieldLabel.textColor = UIColor.lightGray
        fieldLabel.isHidden = true
        
        invalidMessageLabel.textColor = UIColor.red
        invalidMessageLabel.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(AuthTextFieldViewController.textDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func updateViewConstraints() {
        
        if let prompt = promptText {
            let initialSize = CGSize(width: promptLabel.frame.size.width, height: 10000)
            let desiredSize = NSString(string: prompt).boundingRect(with: initialSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: promptLabel.font!], context: nil)
            promptLabelHeightConstraint.constant = desiredSize.height
        }
        
        textBorder.snp.updateConstraints { (make) in
            make.left.equalTo(fieldContainerView)
            make.right.equalTo(fieldContainerView)
            make.bottom.equalTo(textField.snp.bottom)
            make.height.equalTo(0.5)
        }
        super.updateViewConstraints()
    }
    
    // MARK: Animation
    func updateValidLabel(isValid : Bool, message : String?) {
        if isValid {
            UIView.animate(withDuration: 0.2, animations: {
                self.invalidMessageLabel.text = nil
                self.invalidMessageLabel.alpha = 0
                self.textBorder.backgroundColor = UIColor.lightGray
            })
        } else {
            invalidMessageLabel.alpha = 0
            invalidMessageLabel.isHidden = false
            UIView.animate(withDuration: 0.2, animations: { 
                self.invalidMessageLabel.text = message
                self.invalidMessageLabel.alpha = 1.0
                self.textBorder.backgroundColor = UIColor.red
            })
        }
    }
    func showFieldLabel() {
        if !labelIsShown {
            labelIsShown = true
            fieldLabel.alpha = 0
            fieldLabel.isHidden = false
            UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                self.fieldLabel.alpha = 1.0
                self.fieldLabelCenterYConstraint.constant = -30.0
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didFinishTextEntry(controller: self)
        return true
    }
    
    // MARK: Deinit
    
    deinit {
        
    }
}
