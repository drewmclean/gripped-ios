//
//  BiometricsFormViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import CocoaLumberjack
import FirebaseDatabase

class BiometricsFormViewController: FormTableViewController {
    
    var biometricId : String?
    var biometrics : Biometrics? {
        didSet {
            if biometrics != nil {
                let bioValues = biometrics?.fieldValues
                fields.forEach({ (field: FormField) in
                    field.value = bioValues[field.propertyKey]
                })
                updateUI()
            }
        }
    }
    
    static let apeIndexRange : Int = 10
    
    static var apeIndexValues : [String] {
        var values = [String]()
        for i in 0...BiometricsFormViewController.apeIndexRange {
            values.append("\(i)")
        }
        return values
    }
    
    lazy var apeIndexPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = UIColor.white
        picker.dataSource = self
        picker.delegate = self
        picker.reloadAllComponents()
        return picker
    }()
    
    override var cellReuseId: String {
        return "BiometricsFormCellID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardHandlers()
        
        if let _ = biometricId {
            title = "Edit Biometrics"
        } else {
            title = "New Biometrics"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchFields()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateUI() {
        tableView.reloadData()
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
        fields.append(FormField(title: "Ape Index", unit: "cm", propertyKey: Biometrics.Keys.apeIndex) { (textField: UITextField) in
            textField.inputView = self.apeIndexPicker
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
    
    override func fetchFields() {
        if let b = biometricId {
            Biometrics.fetch(key: b, completion: { (error: Error?, snapshot: FIRDataSnapshot?) in
                if let s = snapshot {
                    self.biometrics = Biometrics(snapshot: s)
                    self.updateUI()
                }
            })
        }
    }
    
    override func validateFields() -> Bool {
        return true
    }
    
    override func saveFields() {
        if let bio = biometrics {
            // Update Existing
            
        } else {
            var formValues = fieldValues
            formValues[Biometrics.Keys.userId] = auth.currentUser!.uid
            formValues[Biometrics.Keys.createdAt] = Date().isoString()
            
            // Create New
            Biometrics.create(fieldValues: formValues) { (error: Error?, snapshot: FIRDataSnapshot?) in
                guard let s = snapshot else {
                    return
                }
                
                self.biometrics = Biometrics(snapshot: s)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: API 

extension BiometricsFormViewController : KeyboardAnimator {
    internal func keyboardShowHandler(keyboardFrame: CGRect) {
        
        
        selectApeSign(sign: biometrics?.apeSign)
        selectApeLength(length: biometrics?.apeLength)
        apeIndexPicker.reloadAllComponents()
        
    }
    
    internal func keyboardShowAnimation(keyboardFrame: CGRect) {
        
    }
    
    internal func keyboardHideAnimation(keyboardFrane: CGRect) {
        
    }
}

// MARK: API 

extension BiometricsFormViewController {
    
    
    
}

// MARK: Ape Index

enum ApeIndexPickerViewComponent : Int {
    case sign, length
    static let allValues = [sign, length]
}

extension BiometricsFormViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func selectApeSign(sign : String?) {
        
        func selectPlusSign() {
            apeIndexPicker.selectRow(0, inComponent: ApeIndexPickerViewComponent.sign.rawValue, animated: false)
        }
        
        guard let s = sign else {
            selectPlusSign()
            return
        }
        guard !s.isEmpty else {
            selectPlusSign()
            return
        }
        
        guard let signRow = SignValue.allValues.index(of: SignValue.valueFromRaw(raw: s)!) else {
            selectPlusSign()
            return
        }
        
        apeIndexPicker.selectRow(signRow, inComponent: ApeIndexPickerViewComponent.sign.rawValue, animated: false)

    }
    
    func selectApeLength(length : String?) {
        
        func selectZero() {
            apeIndexPicker.selectRow(0, inComponent: ApeIndexPickerViewComponent.length.rawValue, animated: false)
        }
        
        guard let l = length else {
            selectZero()
            return
        }
        
        guard let lengthRow = BiometricsFormViewController.apeIndexValues.index(of: l) else {
            selectZero()
            return
        }
        
        apeIndexPicker.selectRow(lengthRow, inComponent: ApeIndexPickerViewComponent.length.rawValue, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ApeIndexPickerViewComponent.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == ApeIndexPickerViewComponent.sign.rawValue {
            return SignValue.allValues.count
        } else {
            return BiometricsFormViewController.apeIndexValues.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == ApeIndexPickerViewComponent.sign.rawValue {
            return 44
        } else {
            return 44
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var title:String!
        var attributes:[String:Any]
        if component == ApeIndexPickerViewComponent.sign.rawValue {
            attributes = [NSForegroundColorAttributeName: UIColor.black,
                          NSFontAttributeName: UIFont.boldSystemFont(ofSize: 48)]
            title = SignValue.allValues[row].rawValue
        } else {
            attributes = [NSForegroundColorAttributeName: UIColor.black,
                          NSFontAttributeName: UIFont.boldSystemFont(ofSize: 48)]
            title = BiometricsFormViewController.apeIndexValues[row]
        }
        return NSMutableAttributedString(string: title, attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let apeField = field(forKey: Biometrics.Keys.apeIndex)!
        let signValue = SignValue.allValues[pickerView.selectedRow(inComponent: ApeIndexPickerViewComponent.sign.rawValue)].rawValue
        let lengthValue = BiometricsFormViewController.apeIndexValues[pickerView.selectedRow(inComponent: ApeIndexPickerViewComponent.length.rawValue)]
        apeField.value = "\(signValue)\(lengthValue)"
        let index = fields.index { (field: FormField) -> Bool in
            return field.propertyKey == apeField.propertyKey
        }!
        let indexPath = IndexPath(row:index, section:0)
        if let apeCell = tableView.cellForRow(at: indexPath) as? FormFieldTableViewCell {
            apeCell.textField.text = apeField.value
        }
    }
    
}
