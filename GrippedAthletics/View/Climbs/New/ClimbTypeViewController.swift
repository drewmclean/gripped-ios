//
//  ClimbTypeViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

final class ClimbTypeValue : ComponentsValue, StringRepresentableSource {
    
    override var rawValue: String {
        return components[0].rawValue
    }
    
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
    var providers: [[StringRepresentable]] = [ClimbType.allValues]
}

class ClimbTypeViewController : FormStackItemPickerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = ClimbTypeComponentProvider()
        
        if formField.value.isEmpty {
            formField.value = provider.providers[0][0].rawValue
        }
        
        guard let selectedType = ClimbType.allValues.first(where: { (type: ClimbType) -> Bool in
            type.rawValue == formField.value
        }) else { return }
        
        selectedValue = ClimbTypeValue(components: [selectedType])
    }
    
    override func formattedTextInputValue(sourceValue: String) -> String {
        return sourceValue.capitalized
    }
}

extension ClimbTypeViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedValue = ClimbTypeValue(components: [ClimbType.allValues[row]])
        
    }
}
