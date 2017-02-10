//
//  ClimbTypeViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class ClimbTypeViewController : FormStackItemPickerViewController {
    
    override var allValues: [StringRepresentable] {
        return ClimbType.allValues
    }
    
    override var nextFormItem: FormStackItem? {
        if let value = selectedValue {
            switch value as! ClimbType {
            case .sport:
                return NewClimbFormFieldProvider.Items.sportRating
            case .boulder:
                return NewClimbFormFieldProvider.Items.boulderRating
            default:
                return nil
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
