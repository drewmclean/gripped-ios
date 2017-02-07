//
//  RatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormStackItemPickerViewController: FormStackItemViewController {
    
    var allValues : [StringRepresentable]?
    
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
        self.textField.inputView = pv
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func submitValue() {
        formField.value = selectedValue?.rawValue ?? ""
        super.submitValue()
    }
    
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
