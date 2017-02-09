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
    var sourceViewController : FormStackViewController { get }
    func didCompleteField(controller: FormStackItemViewController, nextFormItem: FormStackItem?)
}

class FormStackItemViewController: UIViewController {
    typealias T = FormInputProvider
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    var delegate : FormStackItemViewControllerDelegate?
    var nextFormItem : FormStackItem? { return nil }
    
    var formField : FormField! {
        didSet {
            
        }
    }
    
    lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 60
        self.view.addSubview(sv)
        return sv
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightLight)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.textAlignment = .center
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
        let size = NSString(string: formField.title).boundingRect(with: CGSize(width: titleWidth, height: 300), options: [.usesDeviceMetrics, .usesLineFragmentOrigin], attributes: [NSFontAttributeName : titleLabel.font], context: nil).size
        return size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        updateUI()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        stackView.snp.updateConstraints { (make) in
            make.center.equalTo(self.view)
        }

        titleLabel.snp.updateConstraints { (make) in
            make.width.lessThanOrEqualTo(titleWidth)
            make.height.equalTo(titleHeight)
        }
        
    }
    
    func updateUI() {
        titleLabel.text = formField.title
        updateViewConstraints()
    }
}

extension FormStackItemViewController {
    func submitValue(completion: (Bool) -> Void) {
        guard let inputProvider = self as? FormInputProvider else {
            completion(false)
            return
        }
        
        formField.value = inputProvider.inputValue!
        completion(formField.isValid)
    }
}

