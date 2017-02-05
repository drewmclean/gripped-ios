//
//  FlowStackItemViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 1/25/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormStackItemViewController: UIViewController {
    
    var formField : FormField! {
        didSet {
            updateUI()
        }
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
        self.stackView.addArrangedSubview(label)
        return label
    }()
    
    lazy var textField : UITextField = {
        var tf = UITextField()
        tf.borderStyle = .none
        tf.delegate = self
        tf.font = UIFont.boldSystemFont(ofSize: 32)
        tf.textColor = UIColor.darkGray
        tf.textAlignment = .center
        self.stackView.addArrangedSubview(tf)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func updateViewConstraints() {
        stackView.snp.updateConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        let titleWidth = view.frame.size.width - 30
        let titleSize = NSString(string: formField.title).boundingRect(with: CGSize(width: titleWidth, height: 300), options: [.usesDeviceMetrics, .usesLineFragmentOrigin], attributes: [NSFontAttributeName : titleLabel.font], context: nil).size
        let titleHeight = max(36, titleSize.height)
        titleLabel.snp.updateConstraints { (make) in
            make.width.equalTo(titleSize.width)
            make.height.equalTo(titleHeight)
        }
        
        textField.snp.updateConstraints { (make) in
            make.width.equalTo(titleSize.width)
            make.height.equalTo(54)
        }
        
        super.updateViewConstraints()
    }
    
    func updateUI() {
        titleLabel.text = formField.title
        textField.text = "Tred" //formField.value
        updateViewConstraints()
    }
}

extension FormStackItemViewController : UITextFieldDelegate {
    
}

