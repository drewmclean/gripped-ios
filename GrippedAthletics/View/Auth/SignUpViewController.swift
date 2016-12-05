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
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.layoutMargins = .zero
        sv.spacing = 0
        self.view.addSubview(sv)
        return sv
    }()

    lazy var nameViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        vc.placeholder = "Name"
        vc.keyboardType = .default
        vc.autocapitalizationType = .words
        vc.returnKeyType = .next
        vc.fieldTitle = "Name"
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
    
    lazy var fieldViewControllers : [AuthTextFieldViewController] = {
        return [self.nameViewController, self.emailViewController, self.passwordViewController]
    }()
    
    lazy var stepIndicator : UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        pageControl.tintColor = UIColor.black
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = stepIndicator
        
        fieldViewControllers.forEach { (vc: AuthTextFieldViewController) in
            vc.willMove(toParentViewController: self)
            addChildViewController(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
        
        addKeyboardHandlers()
        
        stepIndicator.numberOfPages = fieldViewControllers.count
        
        updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showFieldViewController(atIndex: 0, animated: false)
    }
    
    override func updateViewConstraints() {
        
        stackView.snp.updateConstraints { (make) in
            make.width.equalTo(self.view.snp.width).multipliedBy(self.fieldViewControllers.count)
            make.top.equalTo(self.view.snp.top)
            self.stackViewBottomConstraint = make.bottom.equalTo(self.view.snp.bottom).constraint
            self.stackViewLeftConstraint = make.left.equalTo(self.view.snp.left).constraint
        }
        
        fieldViewControllers.forEach { (vc: AuthTextFieldViewController) in
            vc.view.snp.makeConstraints({ (make: ConstraintMaker) in
//                make.width.equalTo(self.view.snp.width)
//                make.height.equalTo(self.view.snp.height)
            })
        }
        
        super.updateViewConstraints()
    }
    // MARK: Show
    
    func showFieldViewController(atIndex index: Int, animated: Bool) {
        
        let vc = fieldViewControllers[index]
        
        navigationItem.rightBarButtonItem?.title = vc.rightBarTitle
        stepIndicator.currentPage = index
//        vc.becomeFirstResponder()
        
        if animated {
            
        } else {
            
        }
    }
    
    func showNextView() {
        
    }
    
    func showPreviousView() {
        
    }
    
    // MARK: KeyboardAnimator
    func keyboardShowAnimation(keyboardFrame: CGRect) {
        stackViewBottomConstraint.update(offset: -keyboardFrame.size.height)
        view.layoutIfNeeded()
    }
    
    func keyboardHideAnimation(keyboardFrane: CGRect) {
        stackViewBottomConstraint.update(offset: 0)
    }

}
