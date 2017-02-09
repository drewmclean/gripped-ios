//
//  RatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormStackItemPickerViewController: FormStackItemTextFieldViewController {
    
    var allValues : [StringRepresentable]?
    
    // MARK: FormInputProvider
    
    var inputValue : String? {
        return selectedValue?.rawValue
    }
    
    var selectedValue : StringRepresentable? {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        guard selectedRow >= 0 else {
            return nil
        }
        guard let value = allValues?[selectedRow] else {
            return nil
        }
        return value
    }
    
    lazy var pickerView : UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.selectRow(0, inComponent: 0, animated: true)
        textField.inputView = pickerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.text = allValues?[0].rawValue.capitalized
    }
    
}

extension FormStackItemPickerViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let count = allValues?.count else { return 0 }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allValues?[row].rawValue.capitalized
    }
    
}

extension FormStackItemPickerViewController {
    
}

extension FormStackItemPickerViewController : UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let value = allValues?[row].rawValue else {
            formField.value = ""
            return
        }
        textField.text = value.capitalized
    }
    
}
