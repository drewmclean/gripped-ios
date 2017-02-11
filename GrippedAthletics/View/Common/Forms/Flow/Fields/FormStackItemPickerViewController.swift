//
//  RatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

protocol PickerComponentProvider {
    var providers : [[StringRepresentable]] { get set }
}

class FormStackItemPickerViewController: FormStackItemTextFieldViewController {

    var provider : PickerComponentProvider!
    
    var selectedValue : ComponentStringRepresentable? {
//        var values : [String] = [String]()
//        for (index, element) in componentProviders.enumerated() {
//            print("Item \(index): \(element)")
//            var value = ""
//            var allComponentValues = element
//            let selectedRow = pickerView.selectedRow(inComponent: index)
//            guard selectedRow > -1 else {
//                return ""
//            }
//            value = allComponentValues[selectedRow].rawValue
//            values.append(value)
//        }
//        let combinedValue = NSArray(array: values).componentsJoined(by: "")
//        return combinedValue
        return nil
    }
    
    lazy var pickerView : UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.inputView = pickerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func updateUI() {
        titleLabel.text = formField.title
        textField.text = inputValue?.capitalized
        updateViewConstraints()
        pickerView.reloadAllComponents()
        
//        if formField.value.isEmpty == false {
//            for (index, allValues) in componentProviders.enumerated() {
//                
//            }
//            if let idx = allValues.index(where: { $0.rawValue == formField.value }) {
//                defaultSelection = idx
//            }
//        } else {
//            formField.value = allValues[defaultSelection].rawValue
//        }
//        pickerView.selectRow(defaultSelection, inComponent: 0, animated: true)
    }
    
    func reloadPickerView() {
        
    }
}

extension FormStackItemPickerViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return provider.providers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let component = provider.providers[component]
        return component.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let component = provider.providers[component]
        return component[row].rawValue.capitalized
    }
    
}

extension FormStackItemPickerViewController {
    
    override var inputValue : String? {
        return selectedValue?.rawValue
    }
    
}

extension FormStackItemPickerViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//       formField.value = value
//        textField.text = value.capitalized
    }
    
}
