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
        dp.addTarget(self, action: #selector(FormStackItemDatePickerViewController.dateValueChanged(_:)), for: .valueChanged)
        return dp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.inputView = datePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateValueChanged(_:Any) {
        
    }
    

}
