//
//  UIViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

// MARK: Storyboard

extension UIViewController {
    
}

// MARK: Keyboard

protocol KeyboardAnimator {
    func keyboardShowAnimation(keyboardFrame : CGRect)
//    func keyboardShowAnimationComplete()
    func keyboardHideAnimation(keyboardFrane : CGRect)
//    func keyboardHideAnimationComplete()
}

extension UIViewController {

    func addKeyboardHandlers() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardHandlers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification : NSNotification) {
        if let keyboardAnimator = self as? KeyboardAnimator {
            if let info = notification.userInfo {
                let keyboardFrame = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
                let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
                let curve = info[UIKeyboardAnimationCurveUserInfoKey] as! UInt
                let curveOption = UIViewAnimationOptions(rawValue: curve)
                
                UIView.animate(withDuration: duration, delay: 0, options: [curveOption], animations: { 
                    keyboardAnimator.keyboardShowAnimation(keyboardFrame: keyboardFrame)
                }, completion: { (finished: Bool) in
//                    keyboardAnimator.keyboardShowAnimationComplete()
                })
            }
        }
    }
    
    func keyboardWillHide(notification : NSNotification) {
        if let keyboardAnimator = self as? KeyboardAnimator {
            if let info = notification.userInfo {
                let keyboardFrame = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
                let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
                let curve = info[UIKeyboardAnimationCurveUserInfoKey] as! UInt
                let curveOption = UIViewAnimationOptions(rawValue: curve)
                
                UIView.animate(withDuration: duration, delay: 0, options: [curveOption], animations: {
                    keyboardAnimator.keyboardHideAnimation(keyboardFrane: keyboardFrame)
                }, completion: { (finished: Bool) in
//                    keyboardAnimator.keyboardHideAnimationComplete()
                })
            }
        }
    }
    
    func keyboardDidShow(notification : NSNotification) {
        
    }
    
    func keyboardDidHide(notification : NSNotification) {
        
    }
}

extension UIViewController {
    func showErrorAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action: UIAlertAction) in
            
        }))
        present(alertController, animated: true, completion: nil)
    }
}
