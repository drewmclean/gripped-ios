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
        dp.minuteInterval = 1
        dp.addTarget(self, action: #selector(FormStackItemDatePickerViewController.dateValueChanged(datePicker:)), for: .valueChanged)
        return dp
    }()
    
    override var inputValue: String? {
        return datePicker.date.isoString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightMedium)
        textField.tintColor = UIColor.clear
        textField.inputView = datePicker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateValueChanged(datePicker: datePicker)
    }
    
    func dateValueChanged(datePicker : UIDatePicker) {
        textField.text = datePicker.date.longString()
    }

}
