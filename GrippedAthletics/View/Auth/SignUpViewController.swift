//
//  SignUpViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController, KeyboardAnimator {
    
    var stackViewBottomConstraint : Constraint!
    var stackViewLeftConstraint : Constraint!
    
    lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        self.view.addSubview(sv)
        return sv
    }()

    lazy var nameViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Name"
        vc.keyboardType = .default
        vc.autocapitalizationType = .words
        vc.returnKeyType = .next
        vc.fieldTitle = "Email"
        vc.rightBarTitle = "Next"
        vc.doneClosure = { (Void) -> Void in
            self.showNextView()
        }
        return vc
    }()
    
    lazy var emailViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Email Address"
        vc.keyboardType = .emailAddress
        vc.returnKeyType = .next
        vc.fieldTitle = "Email"
        vc.rightBarTitle = "Next"
        vc.doneClosure = { (Void) -> Void in
            self.showNextView()
        }
        return vc
    }()
    
    lazy var passwordViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Password"
        vc.keyboardType = .default
        vc.returnKeyType = .done
        vc.isSecureTextEntry = true
        vc.rightBarTitle = "Done"
        vc.fieldTitle = "Password"
        vc.doneClosure = { (Void) -> Void in
            self.showNextView()
        }
        return vc
    }()

    lazy var stepIndicator : UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        pageControl.tintColor = UIColor.black
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = stepIndicator
//        if let rightTitle = rightBarTitle {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightTitle, style: .plain, target: self, action: #selector(SignUpViewController.rightItemTapped(sender:)))
//        }
        
        addKeyboardHandlers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Show
    
    func showNextView() {
        
    }
    
    func showPreviousView() {
        
    }
    
    // MARK: KeyboardAnimator
    func keyboardShowAnimation(keyboardFrame: CGRect) {
        stackViewBottomConstraint.update(offset: keyboardFrame.size.height)
    }
    
    func keyboardHideAnimation(keyboardFrane: CGRect) {
        stackViewBottomConstraint.update(offset: 0)
    }

}
