//
//  RouteVenueViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 2/8/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

final class ClimbVenueValue : ComponentsValue, StringRepresentableSource {
    
    override var rawValue: String {
        return components[0].rawValue
    }
    
    convenience init(rawValue : String) {
        self.init()
        
        ClimbVenue.allValues.forEach({ (type) in
            guard type.rawValue == rawValue else {
                return
            }
            components = [type]
        })
    }
    
}

struct ClimbVenueComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [ClimbVenue.allValues]
}

class ClimbVenueViewController: FormStackItemPickerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        provider = ClimbVenueComponentProvider()
        
        if formField.value.isEmpty {
            formField.value = provider.providers[0][0].rawValue
        }
        
        guard let selectedType = ClimbVenue.allValues.first(where: { (type: ClimbVenue) -> Bool in
            type.rawValue == formField.value
        }) else { return }
        
        selectedValue = ClimbVenueValue(components: [selectedType])
    }
    
    override func formattedTextInputValue(sourceValue: String) -> String {
        return sourceValue.capitalized
    }

}

extension ClimbVenueViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedValue = ClimbVenueValue(components: [ClimbVenue.allValues[row]])
        
    }
}
