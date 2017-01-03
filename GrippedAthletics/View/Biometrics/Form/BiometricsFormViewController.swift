//
//  BiometricsFormViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class BiometricsFormViewController: FormTableViewController {
    
    var biometricId : String?
    
    override var cellReuseId: String {
        return "BiometricsFormCellID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let existingId = biometricId {
            fetchBiometric(key: existingId)
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
            textField.keyboardType = .numberPad
        })
        fields.append(FormField(title: "Weight", unit: "kg", propertyKey: Biometrics.Keys.weight) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .numberPad
        })
        fields.append(FormField(title: "Body Composition", unit: "fat %", propertyKey: Biometrics.Keys.bodyComposition) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .numberPad
        })
        fields.append(FormField(title: "Ape Index", unit: "+/- cm", propertyKey: Biometrics.Keys.apeIndex) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .asciiCapableNumberPad
        })
        fields.append(FormField(title: "Forearm Length", unit: "cm", propertyKey: Biometrics.Keys.forearmLength) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .numberPad
        })
        fields.append(FormField(title: "Forearm Circumference", unit: "cm", propertyKey: Biometrics.Keys.forearmCircumference) { (textField: UITextField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .numberPad
        })
        return fields
    }
    
}

// MARK: API 

extension BiometricsFormViewController {
    
    
}

// MARK: API 

extension BiometricsFormViewController {
    
    func fetchBiometric(key : String) {
        
    }
    
    func saveBiometric() {
        
    }
    
}


// MARK: Ape Index

class ApeIndexPickerViewDataSource : NSObject, UIPickerViewDataSource {
    
    enum ApeIndexPickerViewComponent : Int {
        case sign, length
        static let allValues = [sign, length]
    }
    
    static let apeIndexRange : Int = 10
    
    lazy var apeIndexValues : [String] = {
        var values = [String]()
        for i in 0...ApeIndexPickerViewDataSource.apeIndexRange {
            values.append("\(i)")
        }
        return values
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return SignValue.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ApeIndexPickerViewComponent.allValues.count
    }
}

class ApeIndexPickerViewDelegate : NSObject, UIPickerViewDelegate {
    
}


