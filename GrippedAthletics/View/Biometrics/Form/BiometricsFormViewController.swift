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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let existingId = biometricId {
            fetchBiometric(key: existingId)
        }
        
    }
}

// MARK: API 

extension BiometricsFormViewController {
    
    func fetchBiometric(key : String) {
        
    }
    
    func saveBiometric() {
        
    }
    
}
