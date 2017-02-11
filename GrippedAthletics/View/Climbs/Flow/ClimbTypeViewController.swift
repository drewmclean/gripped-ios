//
//  ClimbTypeViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

struct ClimbTypeComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]]
    
    init() {
        providers = [ClimbType.allValues]
    }
}

class ClimbTypeViewController : FormStackItemPickerViewController {
    
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
        
        provider = ClimbTypeComponentProvider()
    }
}

extension ClimbTypeViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = provider.providers[component][row]
        formField.value = value.rawValue
        updateUI()
    }
}
