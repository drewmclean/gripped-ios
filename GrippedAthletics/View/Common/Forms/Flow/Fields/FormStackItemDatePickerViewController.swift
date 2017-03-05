//
//  FormStackItemDatePickerViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormStackItemDatePickerViewController: FormStackItemTextFieldViewController {
    
    lazy var datePicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.minuteInterval = 5
        dp.addTarget(self, action: #selector(FormStackItemDatePickerViewController.dateValueChanged(datePicker:)), for: .valueChanged)
        return dp
    }()
    
    override var inputValue: String? {
        return datePicker.date.isoString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightMedium)
        textField.tintColor = UIColor.clear
        textField.inputView = datePicker
    }
    
    func dateValueChanged(datePicker : UIDatePicker) {
        textField.text = datePicker.date.longString()
    }
    

}
