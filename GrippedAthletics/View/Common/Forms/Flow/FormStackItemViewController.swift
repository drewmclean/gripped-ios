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
        self.stackView.addArrangedSubview(label)
        return label
    }()
    
    lazy var textField : UITextField = {
        var tf = UITextField()
        tf.borderStyle = .none
        tf.delegate = self
        tf.textAlignment = .center
        tf.tintColor = UIColor.clear
        tf.font = UIFont.boldSystemFont(ofSize: 48)
        tf.textColor = UIColor.darkGray
        self.stackView.addArrangedSubview(tf)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        updateUI()
    }
    
    override func updateViewConstraints() {
        stackView.snp.updateConstraints { (make) in
            make.center.equalTo(self.view)
        }

        let titleWidth = view.frame.size.width - 40
        let titleSize = NSString(string: formField.title).boundingRect(with: CGSize(width: titleWidth, height: 300), options: [.usesDeviceMetrics, .usesLineFragmentOrigin], attributes: [NSFontAttributeName : titleLabel.font], context: nil).size
        let titleHeight = max(36, titleSize.height)
        titleLabel.snp.updateConstraints { (make) in
            make.width.lessThanOrEqualTo(titleWidth)
            make.height.equalTo(titleHeight)
        }
        
        textField.snp.updateConstraints { (make) in
            make.width.equalTo(titleWidth)
            make.height.equalTo(54)
        }
        
        super.updateViewConstraints()
    }
    
    func updateUI() {
        titleLabel.text = formField.title
        textField.text = formField.value
        updateViewConstraints()
    }
}

extension FormStackItemViewController {
    func submitValue() {
        guard let inputProvider = self as? FormInputProvider else {
            return
        }
        
        formField.value = inputProvider.inputValue!
        
        guard formField.isValid else {
            return
        }
        delegate?.didCompleteField(controller: self, nextFormItem: nextFormItem)
    }
}

extension FormStackItemViewController : UITextFieldDelegate {
    
}

