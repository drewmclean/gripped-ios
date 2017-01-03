//
//  FormFieldTableViewCell.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let cellId = "FormFieldTableViewCellID"
    
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var titleStackView : UIStackView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var unitLabel : UILabel!
    @IBOutlet weak var textField : UITextField!
    
    var formField : FormField! {
        didSet {
            updateFieldUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = nil
        unitLabel.text = nil
        textField.text = nil
        textField.delegate = self
    }
    
    func updateFieldUI() {
        titleLabel.text = formField.title
        unitLabel.text = formField.unit
        
        formField.textFieldConfiguration(textField)
    }

}
