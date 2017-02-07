//
//  ClimbTypeViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class ClimbTypeViewController : FormStackItemPickerViewController {
    
    override var nextFormItem: FormStackItem? {
        if let value = selectedValue {
            switch value {
            case :
                
                break
            case .boulder:
                
                break
            default:
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allValues = ClimbType.allValues
    }
    
}
