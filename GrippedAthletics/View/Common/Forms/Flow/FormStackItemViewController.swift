//
//  FlowStackItemViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 1/25/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

protocol FormInputProvider {
    var inputValue : String? { get }
}

protocol FormStackItemViewControllerDelegate {
    var stackProvider : FormStackItemProvider { get }
    var sourceViewController : FormStackViewController { get }
    func didCompleteField(controller: FormStackItemViewController, nextFormItem: FormStackItem?)
}

class FormStackItemViewController: UIViewController {
    typealias T = FormInputProvider
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    var delegate : FormStackItemViewControllerDelegate?
    
    var formItem : FormStackItem!
    
    var formField : FormField {
        return formItem.formField
    }
    
    lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 30
        self.view.addSubview(sv)
        return sv
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightLight)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.textAlignment = .center
//        label.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
        self.stackView.insertArrangedSubview(label, at: 0)
        return label
    }()
    
    var titleWidth : CGFloat {
        return view.frame.size.width - 40
    }
    
    var titleHeight : CGFloat {
        return max(36, titleSize.height)
    }
    
    var titleSize : CGSize {
        let size = NSString(string: formField.title).boundingRect(with: CGSize(width: titleWidth, height: 400), options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName : titleLabel.font], context: nil).size
        return size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        stackView.snp.updateConstraints { (make) in
            make.center.equalTo(self.view)
        }

        titleLabel.snp.updateConstraints { (make) in
            make.width.equalTo(titleWidth)
            make.height.equalTo(titleHeight + 20)
        }

    }
    
    func updateUI() {
        titleLabel.text = formField.title
        updateViewConstraints()
    }
}

extension FormStackItemViewController {
    
    func submitValue(completion: (Bool, FormStackItem?) -> Void) {
        guard let inputProvider = self as? FormInputProvider else {
            completion(false, formItem)
            return
        }
        
        formField.value = inputProvider.inputValue!
        completion(formField.isValid, formItem)
    }
    
}

