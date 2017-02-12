//
//  FormStackItemTextFieldViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 2/8/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import SnapKit

class FormStackItemTextFieldViewController: FormStackItemViewController {

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
        textField.text = ""
    }
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func updateUI() {
        let value = formField.value.capitalized
        print("Setting text: \(value)")
        textField.text = value
        super.updateUI()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        textField.snp.updateConstraints { (make) in
            make.width.equalTo(titleWidth)
            make.height.equalTo(44)
        }
        
    }

}

extension FormStackItemTextFieldViewController : FormInputProvider {
    
    var inputValue : String? {
        return textField.text
    }
    
}

extension FormStackItemTextFieldViewController : UITextFieldDelegate {
    
}

