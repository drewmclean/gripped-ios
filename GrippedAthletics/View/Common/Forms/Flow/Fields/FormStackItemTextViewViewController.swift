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
        tv.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        tv.textColor = UIColor.darkGray
        tv.autocapitalizationType = .sentences
        tv.spellCheckingType = .yes
        tv.delegate = self
        self.stackView.addArrangedSubview(tv)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = ""
//        reloadInputViews()
    }
    
    override var canBecomeFirstResponder: Bool {
        return textView.canBecomeFirstResponder
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
            make.width.equalTo(stackView.snp.width).inset(15)
            make.height.equalTo(200)
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
