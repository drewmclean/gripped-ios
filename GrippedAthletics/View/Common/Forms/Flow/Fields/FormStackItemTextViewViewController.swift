//
//  FormStackItemTextAreaViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 2/8/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormStackItemTextViewViewController: FormStackItemViewController {
    
    lazy var textView : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        self.stackView.addArrangedSubview(tv)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func becomeFirstResponder() -> Bool {
        return textView.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return textView.resignFirstResponder()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        textView.snp.updateConstraints { (make) in
            make.left.equalTo(stackView.snp.left).offset(20)
            make.right.equalTo(stackView.snp.right).offset(20)
            make.height.equalTo(180)
        }
    }

}

// MARK: FormInputProvider

extension FormStackItemTextViewViewController : FormInputProvider {
    
    var inputValue : String? {
        return textView.text
    }
    
}

// MARK: UITextViewDelegate

extension FormStackItemTextViewViewController : UITextViewDelegate {
    
}
