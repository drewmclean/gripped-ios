//
//  AttemptStyleViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

final class AttemptStyleValue : ComponentsValue, StringRepresentableSource {
    
    override var rawValue: String {
        return components[0].rawValue
    }
    
    convenience init(rawValue : String) {
        self.init()
        
        AttemptStyle.allValues.forEach({ (type) in
            guard type.rawValue == rawValue else {
                return
            }
            components = [type]
        })
        
    }
    
}

class AttemptStyleViewController: FormStackItemPickerViewController {
    
    var climbType : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch climbType {
        case ClimbType.sport.rawValue:
            provider = SportStylesComponentProvider()
            break
        case ClimbType.boulder.rawValue:
            provider = BoulderStylesComponentProvider()
            break
        case ClimbType.trad.rawValue:
            provider = TradStylesComponentProvider()
            break
        default:
            provider = SportStylesComponentProvider()
        }
    }
    
    override func formattedTextInputValue(sourceValue: String) -> String {
        return sourceValue.capitalized
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        selectedValue = AttemptStyleValue(components: [provider.providers[component][row]])
        
    }
}

struct SportStylesComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [AttemptStyle.sportValues]
}

struct BoulderStylesComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [AttemptStyle.boulderValues]
}

struct TradStylesComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [AttemptStyle.tradValues]
}

