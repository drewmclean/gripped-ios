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
    
    var placeholder : String?
    var keyboardType : UIKeyboardType = .default
    var returnKeyType : UIReturnKeyType = .default
    var fieldTitle : String?
    var numberOfSteps : Int = 1
    var currentStep : Int = 1
    var doneClosure : ((String) -> Void)!
    
    private var labelIsShown : Bool = false
    
    var backBarLabel : String?
    var rightBarTitle : String?

    lazy var stepIndicator : UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        pageControl.tintColor = UIColor.black
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = stepIndicator
        if let rightTitle = rightBarTitle {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightTitle, style: .plain, target: self, action: #selector(AuthTextFieldViewController.rightItemTapped(sender:)))
        }
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        fieldLabel.text = fieldTitle
        stepIndicator.numberOfPages = numberOfSteps
        stepIndicator.currentPage = currentStep
        
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
    
    // MARK: Validation 
    
    func validateText() -> Bool {
        return true
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
