//
//  UIViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import PKRevealController

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

// MARK: Globals

extension UIViewController {
    
    var auth : Auth {
        return Auth.instance
    }
    
}

// MARK: Data

extension UIViewController {
    
    
    
}

// MARK: Alerts

extension UIViewController {
    
    func showErrorAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action: UIAlertAction) in
            
        }))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Navigation Items

enum NavItemType : Int {
    case back, close, next, done, mainMenu, profile, standardText, add, remove
}

extension UIViewController {
    
    func barItemWithTitle(title: String?, target: Any?, action: Selector?) -> UIBarButtonItem {
        return barItemForNavType(withType: .standardText, title: title, target: target, action: action)
    }
    
    func barItemForNavType(withType type: NavItemType) -> UIBarButtonItem {
        return barItemForNavType(withType: type, title: nil, target: nil, action: nil)
    }
    
    func barItemForNavType(withType type: NavItemType, title: String?, target: Any?, action: Selector?) -> UIBarButtonItem {
        var item : UIBarButtonItem!
        switch type {
        case .back:
            item = UIBarButtonItem(image: UIImage.back, style: .plain, target: self, action: #selector(UIViewController.backButtonTapped(sender:)))
            break
        case .next:
            item = UIBarButtonItem(image: UIImage.forward, style: .plain, target: target, action:action)
            break
        case .done:
            item = UIBarButtonItem(image: UIImage.checkmark, style: .plain, target: target, action:action)
            break
        case .close:
            item = UIBarButtonItem(image: UIImage.close, style: .plain, target: self, action: #selector(UIViewController.backButtonTapped(sender:)))
            break
        case .mainMenu:
            item = UIBarButtonItem(image: UIImage.menu, style: .plain, target: self, action: #selector(UIViewController.menuButtonTapped(sender:)))
            break
        case .profile:
            
            break
        case .standardText:
            item = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
            break
        case .add:
            item = UIBarButtonItem(image: UIImage.add, style: .plain, target: target, action:action)
            break
        case .remove:
            item = UIBarButtonItem(image: UIImage.delete, style: .plain, target: target, action:action)
            break
        }
        return item
    }
    
    // MARK: Default Nav Item Actions
    
    internal func backButtonTapped(sender: UIBarButtonItem) {
        if let _ = presentingViewController {
            dismiss(animated: true, completion: nil)
        } else if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    internal func menuButtonTapped(sender: UIBarButtonItem) {
        revealController.show(revealController.leftViewController)
    }
    
}



