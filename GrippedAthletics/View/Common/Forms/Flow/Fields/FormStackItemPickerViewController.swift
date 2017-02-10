//
//  RatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormStackItemPickerViewController: FormStackItemTextFieldViewController {
    
    var componentProviders : [[StringRepresentable]] {
        return [[StringRepresentable]]()
    }
    
    var allValues : [StringRepresentable] {
        return [StringRepresentable]()
    }
    
    var selectedValue : StringRepresentable? {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        guard selectedRow > -1 else {
            return nil
        }
        let value = allValues[selectedRow]
        return value
    }
    
    lazy var pickerView : UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.inputView = pickerView
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func updateUI() {
        var defaultSelection : Int = 0
        if formField.value.isEmpty == false {
            if let idx = allValues.index(where: { $0.rawValue == formField.value }) {
                defaultSelection = idx
            }
        } else {
            formField.value = allValues[defaultSelection].rawValue
        }
        pickerView.selectRow(defaultSelection, inComponent: 0, animated: true)
        
        titleLabel.text = formField.title
        textField.text = inputValue?.capitalized
        updateViewConstraints()
    }
}

extension FormStackItemPickerViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allValues[row].rawValue.capitalized
    }
    
}

extension FormStackItemPickerViewController {
    
    override var inputValue : String? {
        return selectedValue?.rawValue
    }
    
}

extension FormStackItemPickerViewController : UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = allValues[row].rawValue
        formField.value = value
        textField.text = value.capitalized
    }
    
}
