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
            self.createAccount()
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
    
    var currentViewControllerIndex : Int!
    var currentViewController : AuthTextFieldViewController {
        return fieldViewControllers[currentViewControllerIndex]
    }
    
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
        
        showFieldViewController(atIndex: 0, animated: true)
    }
    
    override func updateViewConstraints() {
        
        stackView.snp.updateConstraints { (make) in
            make.width.equalTo(self.view.snp.width).multipliedBy(self.fieldViewControllers.count)
            make.top.equalTo(self.view.snp.top)
            self.stackViewBottomConstraint = make.bottom.equalTo(self.view.snp.bottom).constraint
            make.left.equalTo(self.view.snp.left)
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: Show
    
    func showFieldViewController(atIndex index: Int, animated: Bool) {
        currentViewControllerIndex = index
        
        let vc = fieldViewControllers[index]
        
        if let rightTitle = vc.rightBarTitle {
            let rightItem = UIBarButtonItem(title: rightTitle, style: .plain, target: self, action: #selector(SignUpViewController.rightItemTapped(sender:)))
            navigationItem.setRightBarButton(rightItem, animated: animated)
        } else {
            navigationItem.setRightBarButton(nil, animated: animated)
        }
        
        if index == 0 {
            let leftItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(SignUpViewController.backItemTapped(sender:)))
            navigationItem.setLeftBarButton(leftItem, animated: animated)
        } else {
            navigationItem.hidesBackButton = false
            let leftItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(SignUpViewController.backItemTapped(sender:)))
            navigationItem.setLeftBarButton(leftItem, animated: animated)
        }
        
        stepIndicator.currentPage = index
        
        stackView.snp.updateConstraints { (make: ConstraintMaker) in
            let width = self.view.frame.size.width
            let offset = width * CGFloat(index)
            make.left.equalTo(-offset)
        }
        
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: [UIViewAnimationOptions.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
                vc.becomeFirstResponder()
            })
        } else {
            view.layoutIfNeeded()
            vc.becomeFirstResponder()
        }
    }
    
    func showNextView() {
        let nextIndex = currentViewControllerIndex + 1
        showFieldViewController(atIndex: nextIndex, animated: true)
    }
    
    func showPreviousView() {
        let previousIndex = currentViewControllerIndex - 1
        showFieldViewController(atIndex: previousIndex, animated: true)
    }
    
    // MARK: Actions
    
    func rightItemTapped(sender:UIBarButtonItem) {
        if currentViewController == passwordViewController {
            createAccount()
        } else {
            showNextView()
        }
    }
    
    func backItemTapped(sender:UIBarButtonItem) {
        if currentViewControllerIndex == 0 {
            dismiss(animated: true, completion: nil)
        } else {
            showPreviousView()
        }
    }
    
    // MARK: KeyboardAnimator
    func keyboardShowAnimation(keyboardFrame: CGRect) {
        stackViewBottomConstraint.update(offset: -keyboardFrame.size.height)
        view.layoutIfNeeded()
    }
    
    func keyboardHideAnimation(keyboardFrane: CGRect) {
        stackViewBottomConstraint.update(offset: 0)
    }
    
    // MARK: API
    
    func createAccount() {
        
    }

}
