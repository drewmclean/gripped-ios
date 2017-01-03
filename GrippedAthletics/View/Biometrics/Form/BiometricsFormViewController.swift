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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let existingId = biometricId {
            fetchBiometric(key: existingId)
        }
        
    }
    
    override func createFields() -> [FormField] {
        var fields = [FormField]()
        fields.append(FormField(title: "Height", unit: "cm", propertyKey: "height") { (textField: UITextField) in
            
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
