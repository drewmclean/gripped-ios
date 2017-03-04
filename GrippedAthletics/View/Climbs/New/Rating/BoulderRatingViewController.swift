//
//  BoulderRatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

final class BoulderRatingValue : ComponentsValue, StringRepresentableSource {
    
    override var rawValue: String {
        return components[0].rawValue
    }
    
    convenience init(rawValue : String) {
        self.init()
        
        Ratings.Hueco.allValues.forEach({ (type) in
            guard type.rawValue == rawValue else {
                return
            }
            components = [type]
        })
    }
    
}

struct BoulderRatingComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [Ratings.Hueco.allValues]
}

class BoulderRatingViewController: FormStackItemPickerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.font = UIFont.systemFont(ofSize: 54, weight: UIFontWeightMedium)
        
        provider = BoulderRatingComponentProvider()
        
        if formField.value.isEmpty {
            formField.value = provider.providers[0][0].rawValue
        }
        
        guard let selectedType = Ratings.Hueco.allValues.first(where: { (type: Ratings.Hueco) -> Bool in
            type.rawValue == formField.value
        }) else { return }
        
        selectedValue = BoulderRatingValue(components: [selectedType])

    }
    
}

extension BoulderRatingViewController {
    override func formattedTitle(forComponent component: Int, title: String) -> String {
        return title.uppercased()
    }
}

extension BoulderRatingViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedValue = BoulderRatingValue(components: [Ratings.Hueco.allValues[row]])
        
    }
}
