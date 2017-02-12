//
//  ClimbTypeViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

final class ClimbTypeValue : ComponentsValue, StringRepresentableSource {
    
    convenience init(rawValue : String) {
        self.init()
        
        ClimbType.allValues.forEach({ (type) in
            guard type.rawValue == rawValue else {
                return
            }
            components = [type]
        })
    }
    
}

struct ClimbTypeComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] {
        return [ClimbType.allValues]
    }
}

class ClimbTypeViewController : FormStackItemPickerViewController {
    
    var newClimbProvider : NewClimbFormFieldProvider {
        return provider as! NewClimbFormFieldProvider
    }
    
    override var nextFormItem: FormStackItem? {
        guard let value = selectedValue else { return nil }
        
        switch value.components[0] as! ClimbType {
        case .sport:
            return self.newClimbProvider.sportRating
        case .boulder:
            return self.newClimbProvider.boulderRating
        default:
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = ClimbTypeComponentProvider()
        formField.value = provider.providers[0][0].rawValue
        
        if !formField.value.isEmpty {
            guard let selectedType = ClimbType.allValues.first(where: { (type: ClimbType) -> Bool in
                type.rawValue == formField.value
            }) else { return }
            
            selectedValue = ClimbTypeValue(components: [selectedType])
        }
    }
    
}

extension ClimbTypeViewController {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        selectedValue = ClimbTypeValue(components: [ClimbType.allValues[row]])
        
    }
}
