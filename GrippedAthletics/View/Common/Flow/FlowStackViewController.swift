//
//  FlowStackViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 1/25/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import SwiftValidator
import SnapKit

protocol FlowStackViewControllerDelegate {
    func didCompleteFlow(controller : FlowStackViewController)
}

class FlowStackViewController: UIViewController {
    
    var delegate : FlowStackViewControllerDelegate?
    
    lazy var validator : Validator = {
        let v = Validator()
        return v
    }()
    
    var fieldViewControllers : [FlowStackItemViewController]! {
        return []
    }
    
    lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor.black
        pc.pageIndicatorTintColor = UIColor.lightGray
        return pc
    }()
    
    lazy var pageControlContainer : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        view.addSubview(self.pageControl)
        return view
    }()
    
    var currentViewControllerIndex : Int!
    var currentViewController : FlowStackItemViewController {
        return fieldViewControllers[currentViewControllerIndex]
    }
    
    var lastViewController : FlowStackItemViewController {
        return fieldViewControllers[fieldViewControllers.count - 1]
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = pageControlContainer
        
        pageControl.isHidden = fieldViewControllers.count <= 1
        
        fieldViewControllers.forEach { (vc: FlowStackItemViewController) in
            vc.willMove(toParentViewController: self)
            addChildViewController(vc)
            stackView.addArrangedSubview(vc.view)
            vc.didMove(toParentViewController: self)
        }
        
        addKeyboardHandlers()
        
        pageControl.numberOfPages = fieldViewControllers.count
        
        updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showFieldViewController(atIndex: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        
        pageControl.snp.updateConstraints { (make) in
            make.center.equalTo(pageControlContainer.center)
        }
        
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
        
        let vc = currentViewController
        
        if index == 0 {
            navigationItem.setLeftBarButton(barItemForNavType(withType: .close, title: "Cancel", target: self, action: #selector(AuthFlowViewController.backItemTapped(sender:))), animated: true)
            navigationItem.setRightBarButton(barItemForNavType(withType: .next, title: "Next", target: self, action: #selector(AuthFlowViewController.rightItemTapped(sender:))), animated: true)
        }
        else if index == fieldViewControllers.count - 1 {
            navigationItem.setLeftBarButton(barItemForNavType(withType: .back, title: "Back", target: self, action: #selector(AuthFlowViewController.backItemTapped(sender:))), animated: true)
            navigationItem.setRightBarButton(barItemForNavType(withType: .done, title: "Done", target: self, action: #selector(AuthFlowViewController.rightItemTapped(sender:))), animated: true)
        }
        else {
            navigationItem.setLeftBarButton(barItemForNavType(withType: .back, title: "Back", target: self, action: #selector(AuthFlowViewController.backItemTapped(sender:))), animated: true)
            navigationItem.setRightBarButton(barItemForNavType(withType: .next, title: "Next", target: self, action: #selector(AuthFlowViewController.rightItemTapped(sender:))), animated: true)
        }
        
        pageControl.currentPage = index
        
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
    
    func submitForm() {
        
    }
    
    func enterMainApplication() {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    func backItemTapped(sender:UIBarButtonItem) {
        if currentViewControllerIndex == 0 {
            currentViewController.view.endEditing(true)
            dismiss(animated: true, completion: nil)
        } else {
            showPreviousView()
        }
    }
    
    func rightItemTapped(sender:UIBarButtonItem) {
        delegate?.didCompleteFlow(controller: self)
    }
    
}

// MARK: KeyboardAnimator

extension FlowStackViewController {
    
    internal func keyboardShowHandler(keyboardFrame: CGRect) {
        
    }
    
    internal func keyboardShowAnimation(keyboardFrame: CGRect) {
        stackViewBottomConstraint.update(offset: -keyboardFrame.size.height)
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
    }
    
    internal func keyboardHideAnimation(keyboardFrane: CGRect) {
        stackViewBottomConstraint.update(offset: 0)
    }
    
    internal func didFinishTextEntry(controller: FlowStackItemViewController) {
        validator.validateField(controller.value as ) { (error: ValidationError?) -> Void in
            if let e = error {
                controller.updateValidLabel(isValid: false, message: e.errorMessage)
                return
            }
            controller.updateValidLabel(isValid: true, message: nil)
            
            if currentViewController == lastViewController {
                submitForm()
                delegate?.didCompleteFlow(controller: self)
            } else {
                showNextView()
            }
        }
    }
  
}
