//
//  YesNoPickerViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

enum BooleanOptions : String, StringRepresentable {
    case yes = "yes"
    case no = "no"
    
    static let allValues = [yes, no]
    
    var boolValue : Bool {
        return rawValue == BooleanOptions.yes.rawValue ? true : false
    }
}

struct YesNoProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [BooleanOptions.allValues]
}

final class YesNoValue : ComponentsValue, StringRepresentableSource {
    
    override var rawValue: String {
        return components[0].rawValue
    }
    
    convenience init(rawValue : String) {
        self.init()
        
        BooleanOptions.allValues.forEach({ (type) in
            guard type.rawValue == rawValue else {
                return
            }
            components = [type]
        })
        
    }
    
}

class YesNoPickerViewController: FormStackItemPickerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = YesNoProvider()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = YesNoValue(components: [provider.providers[component][row]])
    }
    
    override func formattedTextInputValue(sourceValue: String) -> String {
        return sourceValue.capitalized
    }
}
