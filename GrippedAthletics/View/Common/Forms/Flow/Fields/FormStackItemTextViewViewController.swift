//
//  FormStackItemTextAreaViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 2/8/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormStackItemTextAreaViewController: FormStackItemViewController {
    
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
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }

}

// MARK: UITextViewDelegate

extension FormStackItemTextAreaViewController : UITextViewDelegate {
    
}
