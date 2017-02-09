//
//  SportRatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class SportRatingViewController: FormStackItemPickerViewController {

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
        
        allValues = ClimbType.allValues
    }

}
