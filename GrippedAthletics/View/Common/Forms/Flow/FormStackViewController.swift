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

struct FormStackItem {
    var formField : FormField
    var itemViewController : FormStackItemViewController
}

protocol FormStackViewControllerDelegate {
    func didCancelForm(controller : FormStackViewController)
    func didCompleteForm(controller : FormStackViewController)
    func didStepForward(controller : FormStackViewController)
    func didStepBackward(controller : FormStackViewController)
}

class FormStackViewController: UIViewController {
    
    var provider : FormStackItemProvider? {
        didSet {
            reloadViews()
        }
    }
    
    var delegate : FormStackViewControllerDelegate?
    
    lazy var validator : Validator = {
        let v = Validator()
        return v
    }()
    
    var currentItemIndex : Int = 0
    var currentItem : FormStackItem? {
        return items?[currentItemIndex]
    }
    var items : [FormStackItem]? {
        return provider?.items
    }
    
    var fieldViewControllers : [FormStackItemViewController]! {
        return items!.map({ (item : FormStackItem) -> FormStackItemViewController in
            return item.itemViewController
        })
    }
    
    var currentViewControllerIndex : Int = 0
    var currentViewController : FormStackItemViewController {
        return fieldViewControllers[currentViewControllerIndex]
    }
    
    var lastViewController : FormStackItemViewController {
        return fieldViewControllers[fieldViewControllers.count - 1]
    }
    
    var stackViewBottomConstraint : Constraint!
    var stackViewBottomOffset : CGFloat = 0
    
    lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.layoutMargins = .zero
        sv.spacing = 0
        sv.alpha = 0
        self.view.addSubview(sv)
        return sv
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = pageControlContainer
        
        addKeyboardHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showFieldViewController(atIndex: 0, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshPageControl() {
        guard let viewControllers = fieldViewControllers else {
            pageControl.isHidden = true
            return
        }
        
        pageControl.isHidden = viewControllers.count <= 1
        pageControl.numberOfPages = viewControllers.count
    }
    
    override func updateViewConstraints() {
        
        pageControl.snp.updateConstraints { (make) in
            make.center.equalTo(pageControlContainer.center)
        }
        
        stackView.snp.updateConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            self.stackViewBottomConstraint = make.bottom.equalTo(self.view.snp.bottom).offset(stackViewBottomOffset).constraint
            make.left.equalTo(self.view.snp.left)
            
            if let count = items?.count {
                make.width.equalTo(self.view.snp.width).multipliedBy(max(1, count))
            } else {
                make.width.equalTo(self.view.snp.width)
            }
        }
        
        super.updateViewConstraints()
    }
    
}

// MARK: Navigation

extension FormStackViewController {
    
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
                vc.textField.becomeFirstResponder()
            })
        } else {
            view.layoutIfNeeded()
            vc.textField.becomeFirstResponder()
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
    
    func enterMainApplication() {
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: Actions

extension FormStackViewController {
    
    func backItemTapped(sender:UIBarButtonItem) {
        if currentViewControllerIndex == 0 {
            currentViewController.view.endEditing(true)
            dismiss(animated: true, completion: nil)
            delegate?.didCancelForm(controller: self)
        } else {
            showPreviousView()
            delegate?.didStepBackward(controller: self)
        }
    }
    
    func rightItemTapped(sender:UIBarButtonItem) {
        if currentViewControllerIndex >= fieldViewControllers.count - 1 {
            delegate?.didCompleteForm(controller: self)
        } else {
            delegate?.didStepForward(controller: self)
        }
    }
}

// MARK: Form Control

extension FormStackViewController {
    
    func submitForm() {
        
    }
    
}

// MARK: Item Control

extension FormStackViewController {
    
    func appendFormItem(item: FormStackItem) {
        provider?.items.append(item)
        addViewController(forItem: item)
        refreshPageControl()
    }
    
    func appendFormItems(items: [FormStackItem]) {
        provider?.items.append(contentsOf: items)
        provider?.items.forEach { (item:FormStackItem) in
            self.addViewController(forItem: item)
        }
        refreshPageControl()
    }
    
    func addViewController(forItem item : FormStackItem) {
        let vc = item.itemViewController
        vc.willMove(toParentViewController: self)
        addChildViewController(vc)
        stackView.addArrangedSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    func reloadViews() {
        stackView.arrangedSubviews.forEach { (view:UIView) in
            stackView.removeArrangedSubview(view)
        }
        items?.forEach { (item: FormStackItem) in
            addViewController(forItem: item)
        }
        refreshPageControl()
        updateViewConstraints()
    }
}

// MARK: KeyboardAnimator

extension FormStackViewController : KeyboardAnimator {
    
    internal func keyboardShowHandler(keyboardFrame: CGRect) {
        stackViewBottomOffset = -keyboardFrame.size.height
        stackViewBottomConstraint.update(offset: stackViewBottomOffset)
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
        
        guard stackView.alpha == 0 else {
            return
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.alpha = 1.0
        }
    }
    
    internal func keyboardShowAnimation(keyboardFrame: CGRect) {
        
    }
    
    internal func keyboardHideAnimation(keyboardFrane: CGRect) {
        stackViewBottomConstraint.update(offset: 0)
    }
  
}
