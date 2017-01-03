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

extension BiometricsFormViewController {
    
    
}

// MARK: API 

extension BiometricsFormViewController {
    
    func fetchBiometric(key : String) {
        
    }
    
    func saveBiometric() {
        
    }
    
}
