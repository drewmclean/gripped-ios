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
    var followingItemsClosure : ((Void) -> [FormStackItem])?
    
    init(formField : FormField, itemViewController : FormStackItemViewController) {
        self.init(formField: formField, itemViewController: itemViewController, followingItems: nil)
    }
    
    init(formField : FormField, itemViewController : FormStackItemViewController, followingItems : ((Void) -> [FormStackItem])?) {
        
        self.formField = formField
        self.itemViewController = itemViewController
        self.followingItemsClosure = followingItems
        
        itemViewController.formItem = self
    }
}

protocol FormStackViewControllerDelegate {
    func didCancelForm(controller : FormStackViewController)
    func didCompleteForm(controller : FormStackViewController)
    func didStepForward(controller : FormStackViewController)
    func didStepBackward(controller : FormStackViewController)
}

class FormStackViewController: UIViewController {
    
    var provider : FormStackItemProvider?
    
    var isFirstFormItem : Bool {
        return currentItemIndex == 0
    }
    
    var isLastFormItem : Bool {
        
        guard currentItemIndex == items!.count - 1 else {
            return false
        }
        
        guard let _ = currentItem?.followingItemsClosure else {
            return false
        }
        
        return true
    }
    
    var delegate : FormStackViewControllerDelegate?
    
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
    
    var currentViewController : FormStackItemViewController {
        return fieldViewControllers[currentItemIndex]
    }
    
    var lastViewController : FormStackItemViewController {
        return fieldViewControllers[fieldViewControllers.count - 1]
    }
    
    var stackViewBottomConstraint : Constraint!
    var stackViewBottomOffset : CGFloat = 0
    var stackViewLeftConstraint : Constraint!
    
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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        view.addSubview(self.pageControl)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.setHidesBackButton(true, animated: false)
        
        addKeyboardHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showFieldViewController(atIndex: currentItemIndex, animated: false, shouldBecomeFirstResponder: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        currentViewController.becomeFirstResponder()
        
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
        super.updateViewConstraints()
        
        pageControl.snp.updateConstraints { (make) in
            make.center.equalTo(pageControlContainer)
        }
    
        stackView.snp.updateConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            self.stackViewBottomConstraint = make.bottom.equalTo(self.view.snp.bottom).offset(stackViewBottomOffset).constraint
            stackViewLeftConstraint = make.left.equalTo(self.view).constraint
        }
    }
    
}

extension FormStackViewController : FormStackItemViewControllerDelegate {
    
    internal var stackProvider : FormStackItemProvider {
        return self.provider!
    }
    
    internal var sourceViewController: FormStackViewController {
        return self
    }
    
    internal func didCompleteField(controller: FormStackItemViewController, nextFormItem: FormStackItem?) {
        guard let next = nextFormItem else {
            submitForm() // Last Form View
            return
        }
        appendFormItem(item: next)
        showNextView()
    }

}

// MARK: Navigation

extension FormStackViewController {
    
    func showFieldViewController(atIndex index: Int, animated: Bool, shouldBecomeFirstResponder : Bool = true) {
        currentItemIndex = index
        
        let vc = currentViewController
        
        updateNavBar(index: index)
        
        pageControl.currentPage = index
        
        let offset : CGFloat = view.frame.size.width * CGFloat(currentItemIndex)
        stackViewLeftConstraint.update(offset: -offset)
        
        func refreshTitle() {
            if currentItemIndex == 0 {
                navigationItem.titleView = nil
            } else {
                navigationItem.titleView = pageControlContainer
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: [UIViewAnimationOptions.curveEaseOut], animations: {
                refreshTitle()
                self.view.layoutIfNeeded()
            }, completion: { (finished: Bool) in
                guard shouldBecomeFirstResponder else { return }
                vc.becomeFirstResponder()
            })
        } else {
            refreshTitle()
            view.layoutIfNeeded()
            guard shouldBecomeFirstResponder else { return }
            vc.becomeFirstResponder()
        }
    }
    
    func updateNavBar(index:Int) {
        if index == 0 {
            navigationItem.setLeftBarButton(barItemForNavType(withType: .close, title: "Cancel", target: self, action: #selector(FormStackViewController.leftItemTapped(sender:))), animated: true)
            navigationItem.setRightBarButton(barItemForNavType(withType: .next, title: "Next", target: self, action: #selector(FormStackViewController.rightItemTapped(sender:))), animated: true)
        }
        else if index == fieldViewControllers.count - 1 {
            navigationItem.setLeftBarButton(barItemForNavType(withType: .back, title: "Back", target: self, action: #selector(FormStackViewController.leftItemTapped(sender:))), animated: true)
            
            navigationItem.setRightBarButton(barItemForNavType(withType: .done, title: "Done", target: self, action: #selector(FormStackViewController.rightItemTapped(sender:))), animated: true)
        }
        else {
            navigationItem.setLeftBarButton(barItemForNavType(withType: .back, title: "Back", target: self, action: #selector(FormStackViewController.leftItemTapped(sender:))), animated: true)
            navigationItem.setRightBarButton(barItemForNavType(withType: .next, title: "Next", target: self, action: #selector(FormStackViewController.rightItemTapped(sender:))), animated: true)
        }
    }
    
    func showNextView() {
        let nextIndex = currentItemIndex + 1
        showFieldViewController(atIndex: nextIndex, animated: true)
    }
    
    func showPreviousView() {
        let previousIndex = currentItemIndex - 1
        showFieldViewController(atIndex: previousIndex, animated: true)
    }
}

// MARK: Actions

extension FormStackViewController {
    
    func leftItemTapped(sender:UIBarButtonItem) {
        if currentItemIndex == 0 {
            currentViewController.resignFirstResponder()
            dismiss(animated: true, completion: nil)
            delegate?.didCancelForm(controller: self)
        } else {
            showPreviousView()
            delegate?.didStepBackward(controller: self)
        }
    }
    
    func rightItemTapped(sender:UIBarButtonItem) {
        currentViewController.submitValue { (isValid: Bool, item: FormStackItem?) in
            
            guard isValid else {
                return
            }
            
            if let followUpItems = item?.followingItemsClosure?() {
                appendFormItems(items: followUpItems)
            }
            
            guard currentItemIndex < provider!.items.count - 1 else {
                submitForm()
                return
            }
            
            showNextView()
        }
    }
}

// MARK: Form Submit

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
        vc.delegate = self
        vc.willMove(toParentViewController: self)
        addChildViewController(vc)
        stackView.addArrangedSubview(vc.view)
        vc.view.snp.makeConstraints { (make: ConstraintMaker) in
            make.width.equalTo(self.view)
        }
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
        view.layoutIfNeeded()
        
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
