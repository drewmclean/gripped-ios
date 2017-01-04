//
//  BiometricsFormViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import SnapKit

class BiometricsFormViewController: FormTableViewController {
    
    var biometricId : String?
    
    lazy var apeDelegate = ApeIndexPickerViewDataSourceDelegate()
    
    lazy var apeIndexPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self.apeDelegate
        picker.delegate = self.apeDelegate
        picker.reloadAllComponents()
        return picker
    }()
    
    lazy var apeIndexInputView : UIView = {
        let view = UIView()
        view.addSubview(self.apeIndexPicker)
        view.snp.updateConstraints({ (make:ConstraintMaker) in
            make.left.equalTo(50)
            make.right.equalTo(50)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        })
        return view
    }()
    
    override var cellReuseId: String {
        return "BiometricsFormCellID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardHandlers()
        
        if let existing = biometricId {
            fetchBiometric(key: existing)
            title = "Edit Biometrics"
        } else {
            title = "New Biometrics"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func createFields() -> [FormField] {
        var fields = [FormField]()
        fields.append(FormField(title: "Height", unit: "cm", propertyKey: Biometrics.Keys.height) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .decimalPad
        })
        fields.append(FormField(title: "Weight", unit: "kg", propertyKey: Biometrics.Keys.weight) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .decimalPad
        })
        fields.append(FormField(title: "Body Composition", unit: "fat %", propertyKey: Biometrics.Keys.bodyComposition) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .decimalPad
        })
        fields.append(FormField(title: "Ape Index", unit: "+/- cm", propertyKey: Biometrics.Keys.apeIndex) { (textField: UITextField) in
            textField.inputView = self.apeIndexInputView
        })
        fields.append(FormField(title: "Forearm Length", unit: "cm", propertyKey: Biometrics.Keys.forearmLength) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .decimalPad
        })
        fields.append(FormField(title: "Forearm Circumference", unit: "cm", propertyKey: Biometrics.Keys.forearmCircumference) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .decimalPad
        })
        return fields
    }
    
}

// MARK: API 

extension BiometricsFormViewController : KeyboardAnimator {
    internal func keyboardShowHandler(keyboardFrame: CGRect) {
        apeIndexPicker.reloadAllComponents()
    }
    internal func keyboardShowAnimation(keyboardFrame: CGRect) {
        
    }
    
    internal func keyboardHideAnimation(keyboardFrane: CGRect) {
        
    }
}

// MARK: API 

extension BiometricsFormViewController {
    
    func fetchBiometric(key : String) {
        
    }
    
    func saveBiometric() {
        
    }
    
}

// MARK: Ape Index

enum ApeIndexPickerViewComponent : Int {
    case sign, length
    static let allValues = [sign, length]
}

class ApeIndexPickerViewDataSourceDelegate : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    static let apeIndexRange : Int = 10
        
    var pickerView : UIPickerView!
    
    var selectedApeIndex : String? {
        
        return nil
    }
    
    lazy var apeIndexValues : [String] = {
        var values = [String]()
        for i in 0...ApeIndexPickerViewDataSourceDelegate.apeIndexRange {
            values.append("\(i)")
        }
        return values
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ApeIndexPickerViewComponent.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == ApeIndexPickerViewComponent.sign.rawValue {
            return SignValue.allValues.count
        } else {
            return apeIndexValues.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == ApeIndexPickerViewComponent.sign.rawValue {
            return SignValue.allValues[row].rawValue
        } else {
            return apeIndexValues[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
